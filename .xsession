#!/bin/sh

exec "${HOME}/.sh/xsession"
exec xmessage -center -timeout 15 "Failed to init session!"
