
# Linux systems sometimes argue about en_US.UTF-8 and en_US.utf8.
#
# For example my Debian systems set LANG=en_US.UTF-8 from the get go.  And then
# I ssh into another Debian system and perl moans about LANG because it wants
# en_US.utf8 \o/.
#
# Well behaved linux systems, both Debian and Red Hat, will use either.
#
LANG=en_US.utf-8

#
# Detect the presense of a container, includng its name if possible.
# For some shells, this may be inserted into the prompt.
#
if [ -z "${container_name}" ]; then
    if [ -r /run/.containerenv ]; then
        # OCI containers like Podman use this file to indicate the container is running.
        # It generally contains shell variables describing the container.
        container_name="$(grep -oP "(?<=name=\")[^\";]+" /run/.containerenv)"
    elif [ -r /etc/debian_chroot ]; then
        # Debian systems use this file to indicate a chroot environment. Such as using
        # schroot -c some_chroot = /etc/debian_chroot contains 'some_chroot'.
        container_name="$(cat /etc/debian_chroot)"
    elif [ -r /.dockerenv ]; then
        # non-standard and generally empty.
        container_name="docker"
    elif [ -r /.toolboxenv ]; then
        # about as useless but indicates Fedora toolbox.
        container_name="toolbx"
    fi
fi

#
# If it looks like a Windows Subsystem for Linux: add some WINDOWS_* vars
# - Looks like WSL_DISTRO_NAME is typical; WSLENV and WSL_INTEROP usually set.
# - IS_WSL set to `grep -i microsoft /proc/version` from /etc/profile.
# - And uname usually reports microsoft in the kernel release.
#
if [ -n "$WSL_DISTRO_NAME" -o "$IS_WSL" ]; then
    # no other feedback if %SystemDrive% != C: - unless you wanta analyze $PATH.
    [ -d /mnt/c ] && WINDOWS_SYSTEMDRIVE=/mnt/c
fi

