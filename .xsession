#!/bin/sh
exec "${HOME}/.sh/rc.xinit"
exec xmessage -center -timeout 15 "Failed to init session!"
