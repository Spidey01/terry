#!/bin/sh
#
# My personal X-Session initialization file.
#
#


#
# Force parsing of our current X resources file
#
xrdb -quiet ~/.Xresources

#
# launch a D-Bus channel for this session
#
which dbus-launch >/dev/null && if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi


~/sh/plsetbg &

~/sh/startup-sound.sh &
bbkeys &

fbpanel -p tray &
fbpanel -p pager &

gkrellm &

urxvt -title ${USER}@`hostname -s` -e screen -U &

if [ ! -z "`ifconfig | grep -v lo0 | grep UP`" ]; then
    pidgin &
    #psi &
    xchat --minimize=2 &
fi

~/sh/xkillname xconsole &
blackbox
