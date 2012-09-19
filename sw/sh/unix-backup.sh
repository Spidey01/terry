#!/bin/sh
#
if [ $# -ne 0 ]; then
    echo "usage: `basename $0`"
    echo
    echo "I consume all unix-backup.rc in XDG_CONFIG_HOME and XDG_CONFIG_DIRS."
    echo "All settings are done in those files. See source of $0 for comments."
    exit 0
fi

###################################################################################
# 
# Start of example configuration file.
# 
###################################################################################
#
# Note: the file will be sourced, so you can use shell stuff in the config file.
#
# where to store backups
#
# OUTDIR="~/Backups/hosts/`uname -n`"
#
# Paths to backup with dump.
#
# DUMP_PATHS="/ /home /tmp /usr /var"
#
# The level of dump to take. The default is 0.
#
# DUMP_LEVEL=0
#
# What level to honor for the `nodump` flag. Dump's default is level 1.
#
# DUMP_HONOR_LEVEL=1
#
# A gzip like program to pass through. 
# Must work like dump f - ... | $DUMP_COMPRESS_FORMAT -c > filename.
#   
# The default is to only create a dump file.
#   
# The file extension will be normalized when the program is known (e.g.
# gzip->.tar.gz). Other wise .tar.$COMPRESS_FORMAT is used. Be polite!
#
# DUMP_COMPRESS_FORMAT="bzip2"
#
# Paths to backup with tar.
#
# TAR_PATHS="/etc /usr/local/etc"
#
# A gzip like program to pass through. 
# Must work like tar cf- ... | $TAR_COMPRESS_FORMAT -c > filename.
#
# The default is to only create a tape archive.
#
# The file extension will be normalized when the program is known (e.g.
# gzip->.tar.gz). Other wise .tar.$TAR_COMPRESS_FORMAT is used. Be polite!
#
# TAR_COMPRESS_FORMAT="xz"
#
# Paths to backup with zip.
#
# ZIP_PATHS=""
#
# Arg to the -n option of info zip. E.g. ="*.foo:*.bar".
#
# ZIP_NO_COMPRESS=".gz:.bz2:.xz:.Z:.tar:.tar.gz:.tar.bz2:.tar.xz:.tar.Z:.tgz:.tbz2:.txz:.jar:.apk"
#
# Set this to any value for extra pretty output.
#
# DEBUG=true;
#
###################################################################################
# 
# End of example configuration file.
# 
###################################################################################


debug_echo() {
    # export debug before running, in order to make pretty loud output.
    [ -n "$DEBUG" ] && echo "$@"
}

source_file() {
    # just source the file into our script.
    if [ -f "$1" ]; then
        debug_echo "Sourcing $1"
        . "$1"
    fi
}

eval_for_each() {
    # does eval 'str' over a word list.
    local cmd what

    cmd="$1"
    shift 1
    # echo '$1 = '$1' $@ = '"$@"

    for what in $@; do
        eval "$cmd" "$what"
    done
}

add_to_path() {
    # mutator for PATH.
    local opt pflag eflag

    while getopts "ep" opt; do
        # echo "opt=$opt \$@=$@"
        case $opt in
            p)
                pflag=true
                ;;
            e)
                eflag=true
                ;;
            \?)
                echo "Error: bare '-' unknown. Args were \$@='$@'"
                return 1
                ;;
        esac
    done
    shift `expr $OPTIND - 1`

    if [ -n $eflag ] && echo "$PATH" | grep "$1" >/dev/null 2>/dev/null
    then
        debug_echo "'$@' already in PATH"
        return 0
    fi

    if [ -n "$pflag" ]; then
        debug_echo "Prepending '$@' to PATH"
        PATH="$@:$PATH"
    else
        debug_echo "Appending '$@' to PATH"
        PATH="$PATH:$@"
    fi
}

make_archive_name() {
    # convert a name like /usr/local/ into usr-local.
    # also .foo -> dot-foo
    echo "$@" | sed -e 's/\//-/g' | sed -e 's/^-//' | sed -e 's/-$//' \
        | sed -e 's/^\./dot-/g'
}

get_ext() {
    # figure out what to name the damn thing.
    case "$1" in
        gzip)
            echo gz
            ;;
        bzip2)
            echo bz2
            ;;
        compress)
            # does compress even work like | compress -c > file?
            echo Z
            ;;
        *)
            echo "$1"
            ;;
    esac
}

get_date() {
    date +'%Y-%m-%dT%H:%M%z'
}

do_dump() {
    local dump_path dump_args dump_level dump_name dump_date

    dump_level="${DUMP_LEVEL:-0}"

    echo '# ${dump_name}:${dump_level}:${dump_date}' >> $OUTDIR/dump.index

    for dump_path 
    do
        echo "dumping $dump_path"

        # check if the path is a file system or a directory.
        # dump can only update the dumpdates file for devices, not subdirs.
        if grep "$dump_path" /etc/fstab >/dev/null
        then
            dump_args="-u $dump_args"
        # else
            # dump_args=""
        fi

        # see if we're overriding the nodump handling.
        if [ -n "$DUMP_HONOR_LEVEL" ]
        then
            dump_args="-h $DUMP_HONOR_LEVEL $dump_args"
        fi

        dump_name="$OUTDIR/`make_archive_name $dump_path`.${dump_level}.dump"
        dump_date="`get_date`"

        dump $dump_args -$dump_level -f "$dump_name" "$dump_path"

        if [ $? -ne 0 ]; then
            echo "dumping $dump_path failed!"
            continue
        fi

        # we have to do compression second, other wise we can't detect failure above.
        if [ -n "$DUMP_COMPRESS_FORMAT" ]
        then
            echo "Compressing with $DUMP_COMPRESS_FORMAT"
            $DUMP_COMPRESS_FORMAT $dump_name
            dump_name="${dump_name}.`get_ext $DUMP_COMPRESS_FORMAT`"
            if [ ! -f "$dump_name" ]; then
                echo "Can't find ${DUMP_COMPRESS_FORMAT}'d dump at ${dump_name}."
                echo "There may be sanity problems with the index."
            fi
        fi
        echo "$dump_path was dumped to $dump_name"

        echo "${dump_name}:${dump_level}:${dump_date}" >> $OUTDIR/dump.index
    done
}

do_tar() {
    local tar_path tar_name tar_date

    echo '# ${tar_name}:${tar_path}:${tar_date}' >> $OUTDIR/tar.index

    for tar_path
    do
        echo "taping $tar_path"

        tar_name="$OUTDIR/`make_archive_name $tar_path`.tar"
        tar_date="`get_date`"

        if [ -n "$TAR_COMPRESS_FORMAT" ]
        then
            tar_name="${tar_name}.`get_ext $TAR_COMPRESS_FORMAT`"

            tar cf - "$tar_path" | "$TAR_COMPRESS_FORMAT" -c > "$tar_name"
        else
            tar cf "$tar_name" "$tar_path"
        fi

        if [ $? -eq 0 ]; then
            echo "$tar_path was taped to $tar_name"
            echo "${tar_name}:${tar_path}:${tar_date}" >> $OUTDIR/tar.index
        else
            echo "tar of $tar_path failed"
            continue
        fi
    done
}

do_zip() {
    local zip_path zip_args zip_name zip_date

    [ -n "$ZIP_NO_COMPRESS" ] && zip_args="-n $ZIP_NO_COMPRESS"

    echo '# ${zip_name}:${zip_path}:${zip_date}' >> $OUTDIR/zip.index

    for zip_path
    do
        echo "zipping $zip_path"

        zip_name="$OUTDIR/`make_archive_name $zip_path`.zip"
        zip_date="`get_date`"

        zip -r $zip_args "$zip_name" "$zip_path"

        if [ $? -eq 0 ]; then
            echo "$zip_path was zipped to $zip_name"
            echo "${zip_name}:${zip_path}:${zip_date}" >> $OUTDIR/zip.index
        else
            echo "zip of $zip_path failed!"
            continue
        fi
    done
}


# Look for and process the runtime configuration files.
#
eval_for_each \
    source_file \
    `echo "${XDG_CONFIG_DIRS:-/etc/xdg}" | cut -d: --output-delimiter=' ' -f 1-`

USR_RCFILE="${XDG_CONFIG_HOME:-${HOME}/.config}/unix-backup.rc"
source_file "$USR_RCFILE"

# ensure path is setup.
#
eval_for_each \
    "add_to_path -e -p" \
    "/sbin" "/usr/sbin" "/usr/local/sbin" "${HOME}/sw/sbin" \
    "/bin" "/usr/bin" "/usr/local/bin" "${HOME}/sw/bin" \
    "${HOME}/sw/sh" "${HOME}/sw/sh.local"
export PATH
debug_echo "PATH=$PATH"

# ensure required utilities are available.
#
for app in dump tar zip xz gzip bzip2 compress
do
    if ! type $app
    then
        echo "$app should be in PATH=$PATH"
    fi
done
mkdir -p "$OUTDIR"

# Find out what needs to be backed up.
#

# TODO:
# decide if we need to do backups incrementally or not based on rc files and dump -w output.

eval_for_each \
    do_dump \
    $DUMP_PATHS

eval_for_each \
    do_tar \
    $TAR_PATHS

eval_for_each \
    do_zip \
    $ZIP_PATHS

