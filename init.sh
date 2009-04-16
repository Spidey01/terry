#!/bin/sh
#
# My personal X-Session initialization file.
#
#

# setup a tmpdir and umask for this file
INIT_TMPDIR="${TMPDIR:-/tmp}"
umask 077

#
# Force parsing of our current X resources file
#
xrdb -quiet ~/.Xresources

#
# Fancy shadows and things
#
xcompmgr -CfFns &

#
# launch a D-Bus channel for this session
#
which dbus-launch >/dev/null && if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi

# download dir for MPlayer plugin
mkdir "${INIT_TMPDIR}/mplayer"

#
# Eexecute my primary user interface
#
urxvt -title ${USER}@`hostname -s` -e screen -U &


# launchwall paper changer
mkdir "${INIT_TMPDIR}/plsetbg"
~/sh/plsetbg -D "${INIT_TMPDIR}/plsetbg" &

#
# Window dressings (docs, panels, applets, etc)
#
fbpanel -p tray &
fbpanel -p pager &
gkrellm &

#
# Only launch these if we have an internet connection
#
if [ ! -z "`ifconfig | grep -v lo0 | grep UP`" ]; then
    pidgin &
    #psi &
fi

#
# Last minute stuffs
#
~/sh/xkillname xconsole &
~/sh/startup-sound.sh &
transset-df -n "Terry@dixie" .9

# start the big kahuna
fvwm
