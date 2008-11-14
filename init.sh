#!/bin/sh
#
# My personal X-Session initialization file.
#
# $Revision$
# $Author$
#

~/sh/psetbg &

~/sh/startup-sound.sh &
bbkeys &
dcopserver &

fbpanel -p tray &
fbpanel -p pager &

gkrellm &

urxvt -title ${USER}@`hostname -s` -e screen &

pidgin &
psi &

blackbox
