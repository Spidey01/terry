#!/bin/sh
#
# My personal X-Session initialization file.
#
# $Revision$
# $Author$
#

#
# override our locale environment
#
# locale related settings   (DEFAULT)
TZ='Etc/UTC'; export TZ                 # my time zone
LANG='en_US.UTF-8'; export LANG         # language.encoding
# some programs require us to set LC_ALL manually as well.
LC_ALL='en_US.UTF-8'; export LC_ALL
MM_CHARSET='UTF-8'; export MM_CHARSET


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
