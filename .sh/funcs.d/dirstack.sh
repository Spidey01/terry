#
# Emulation of directory stack for very ancient / minimalist bourne shells.
#

emulate_pushd() {
    DIRSTACK="$1 ${DIRSTACK:-`pwd`}"
    cd $1 && emulate_dirs
}

emulate_popd() {
    set -- $DIRSTACK
    shift
    DIRSTACK="$*"

    # done this way in case of an error with chdir
    if [ -z "$1" ]; then
        cd $1 && emulate_dirs
    else
        emulate_dirs
    fi
}

emulate_dirs() {
    local args i

    args=`getopt clpv $* 2> /dev/null`
    if [ $? -ne 0 ]; then
        # handle wrong options here.
        echo "usage: emulate_dirs [-cplv]"
    fi
    set -- $args

    for args do
        case $args in
           # no args; print with ~'s
           --)  type perl >/dev/null 2>/dev/null
                if [ $? -ne 0 ]; then
                    # perl not found, fall back on dirs -l
                    emulate_dirs -l
                    return
                fi
                echo $DIRSTACK | perl -pe 's%$ENV{HOME}%~%g'
                shift; break
                ;;
           # erase dir stack
           -c)  DIRSTACK=""
                shift; break
                ;;
           # list with ~'s expanded, our normal behavour
           -l)  echo $DIRSTACK
                shift; break
                ;;
           # print on own line
           -p)  for args in $DIRSTACK
                do
                    echo $args
                done
                shift; break
                ;;
           # print on own line with indexes and tabulators
           -v)  for args in $DIRSTACK
                  do
                      printf "%d\t%s\n" "$i" "$args"
                      i=`expr $i + 1`
                  done
                shift; break
                ;;
            # handled above
            *)  echo "$0: Programmer error if you ever see this"
                shift; break
                ;;
        esac
    done
}
