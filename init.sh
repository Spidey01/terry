#!/bin/sh
#
# My personal X-Session initialization file.
#
# $Revision$
# $Author$
#


#
# launch a D-Bus channel for this session
#
which dbus-launch >/dev/null && if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval `dbus-launch --sh-syntax --exit-with-session`
fi


~/sh/psetbg &

~/sh/startup-sound.sh &
bbkeys &
dcopserver &

fbpanel -p tray &
fbpanel -p pager &

gkrellm &

urxvt -title ${USER}@`hostname -s` -e screen -U &

pidgin &
psi &
xchat --minimize=2 &

blackbox
