#
# GNU Makefile to setup $HOME state
#

MKDIR = mkdir -p $@
LINK = ln -s $< $@
HOSTNAME = `uname -n`

all: hosts tmp sw dropbox_dirs xdg_dirs rc_files 

status:
	git status | $(PAGER)

pull:
	git pull origin

push:
	git push origin
	git push vectra

rc_files: .mutt .vimrc .gvimrc .pythonrc

.mutt: .sh/config.d/mutt .cache/mutt
	$(MKDIR)

.cache/mutt: .cache
	$(MKDIR)

.vimrc: .vim/vimrc
	$(LINK)

.gvimrc: .vim/gvimrc
	$(LINK)

# non version controlled (yet). Just make sure it exists.
.pythonrc:
	touch .pythonrc

dropbox_dirs: Dropbox docs n projs sw/sh.local w

docs: Dropbox/Documents
	$(LINK)

n: Dropbox/Notes
	$(LINK)

projs: Dropbox/Projects
	$(LINK)

sw/sh.local: sw Dropbox/sh/$(shell uname -n)
	$(LINK)

w: Dropbox/Wegener
	$(LINK)

#
# Some of these are my personal preferences and mated to Dropbox.
#
# The rest make certain login scripts happy; e.g. Ubuntu likes to run
# /usr/bin/xdg-user-dirs-update as part of an X session.
#
xdg_dirs: .config .local/share Desktop dls docs music pics Public Templates vids

.cache:
	$(MKDIR)

.config:
	$(MKDIR)

.local/share:
	$(MKDIR)

Desktop: 
	$(MKDIR)

dls:
	$(MKDIR)

music:
	$(MKDIR)

pics:
	$(MKDIR)

Public:
	$(MKDIR)

Templates: Dropbox/Templates
	$(LINK)

vids:
	$(MKDIR)


hosts:
	$(MKDIR)

tmp:
	$(MKDIR)

.PHONY: status pull push .cache .config .local/share .pythonrc Desktop dls music pics Public vids hosts tmp sw
