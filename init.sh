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

pidgin &

Terminal &

blackbox
