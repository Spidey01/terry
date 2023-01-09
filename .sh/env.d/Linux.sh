
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
# Debian systems use this file to indicate a chroot environment. Such as using
# schroot -c some_chroot = /etc/debian_chroot contains 'some_chroot'.
#
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
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

