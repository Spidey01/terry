#!/bin/sh
#
# My personal X-Session initialization file.
#
#

#
# setup a local environment for this scripts run
#
umask 077
HOSTNAME="`echo ${HOSTNAME:-\`hostname\`} | sed 's/\..*//'`"
INIT_TMPDIR="${TMPDIR:-/tmp}"
if [ ! -z "`ifconfig | grep -v lo0 | grep UP`" ]; then
    HAVE_INTERNET_CONNECTION=yes
    export HAVE_INTERNET_CONNECTION
fi
DO_RSYNC() {
    local PATH="${PATH}:/usr/local/bin:${HOME}/sh" 
    notify-send "Please wait" "Running rsync system manager..."
    local OUT="$(rs-mgr)"
    echo "$OUT"
    notify-send "rsync system manager" "$OUT"
}

if [ -n "$HAVE_INTERNET_CONNECTION" ]; then
    DO_RSYNC
fi

#
# launch wall paper changer
#
mkdir "${INIT_TMPDIR}/plsetbg"
~/sh/plsetbg -D "${INIT_TMPDIR}/plsetbg" -c ~/sh/wp-set &

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
xcompmgr -sfF &

fbpanel -p flibber &

#
# Eexecute my primary user interface
#
urxvt -title ${USER}@${HOSTNAME} -e screen -R &


#
# Only launch these if we have an internet connection
#
if [ -n "$HAVE_INTERNET_CONNECTION" -a ! -e ${INIT_TMPDIR}/nochat ]; then
    pidgin &
    xchat --minimize=2 &
fi

#
# Last minute stuffs
#
~/sh/xkillname xconsole &
~/sh/startup-sound.sh &
env PATH="$PATH:${HOME}/sh" ~/sh/rs-touch && echo "TOUCH"
(sleep 25; transset-df -n "${USER}@${HOSTNAME}" .8)&
(sleep 25; transset-df -n "panel" .7)&

# start the big kahuna
FVWM_STYLE=Slate; export FVWM_STYLE
fvwm

# clean up
pkill -s HUP pidgin
pkill -s HUP xchat
kill -s TERM `cat ${INIT_TMPDIR}/plsetbg/pid` && rm -rf "${INIT_TMPDIR}/plsetbg"
echo "X-Session terminated" > /tmp/xsession
