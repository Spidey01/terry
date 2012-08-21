#
# GNU Makefile to setup $HOME state
#

MKDIR = mkdir -p $@
LINK = ln -s $< $@
HOSTNAME = `uname -n`

# command to set the nodump attribute
NODUMP = chattr +d 

all: rc_files dropbox_files no_dump

rc_files: .vimrc .gvimrc .pythonrc .irbrc

# Most of these are optional.
dropbox_files: 
	if [ -d ./Dropbox/Backups -a ! -d ./Backups ]; then ln -s ./Dropbox/Backups ./Backups; else true; fi
	if [ -d ./Dropbox/Documents -a ! -d ./Documents ]; then ln -s ./Dropbox/Documents ./Documents; else true; fi
	if [ -h ./.ssh/keys ]; then true; else \
		if [ -d ./Dropbox/SshKeys -a ! -d .ssh/keys ]; then \
			ln -s ../Dropbox/SshKeys ./.ssh/keys; \
			find .ssh/keys/ -type d -exec chmod 0700 '{}' \; ; \
			find .ssh/keys/ -type f -exec chmod 0600 '{}' \; ; fi; fi

status:
	git status | $(PAGER)

pull:
	git pull origin

push:
	git push origin
	git push vectra

.vimrc: .vim/vimrc
	$(LINK)

.gvimrc: .vim/gvimrc
	$(LINK)

# non version controlled (yet). Just make sure they exist.
.pythonrc:
	touch .pythonrc
.irbrc:
	touch .irbrc

vim-helptags:
	for _D in .vim/bundle/*/doc; do vim -e --cmd "helptags $$_D | q"; done

# stuff that we don't really want in a dump
no_dump:
	if [ -d ./Dropbox ]; then $(NODUMP) ./Dropbox ; else true; fi
	if [ -d ./.cache ]; then $(NODUMP) ./.cache ; else true; fi
	if [ -d ./.dbus/session-bus ]; then $(NODUMP) ./.dbus/session-bus ; else true; fi
	if [ -d ./.m2/repository ]; then $(NODUMP) ./.m2/repository ; else true; fi

.PHONY: status pull push dropbox_files vim-helptags no_dump

