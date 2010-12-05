#!/bin/sh
exec "${HOME}/.sh/env.d/xinit"
xmessage -center -timeout 15 "Failed to init session!"
