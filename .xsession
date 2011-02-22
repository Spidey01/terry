#!/bin/sh
exec "${HOME}/.sh/xinit"
exec xmessage -center -timeout 15 "Failed to init session!"
