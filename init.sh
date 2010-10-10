#!/bin/sh
#
# My personal X-Session initialization file.
#
#

#
# setup a local environment for this scripts run
#
umask 077

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


#
# Fancy shadows and things
#
#xcompmgr -sfF &

# start the big kahuna
startxfce4

# clean up
echo "X-Session terminated"
