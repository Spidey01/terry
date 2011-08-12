#!/bin/sh

# make sure we update PATHto include our stuff because there this file will
# probably be run with the systems notion of PATH.
#
exec \
  env PATH="${HOME}/sw/sh.local:${HOME}/sw/sh:${HOME}/sw/bin:${HOME}/sw/sbin:$PATH" \
    "${HOME}/.sh/xinit"

exec xmessage -center -timeout 15 "Failed to init session!"
