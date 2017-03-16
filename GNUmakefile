#
# GNU Makefile to setup $HOME state
#

MKDIR = mkdir -p $@
LINK = ln -s $< $@
HOSTNAME = `uname -n`

# command to set the nodump attribute
NODUMP = chattr +d 

all: rc_files dropbox_files insync_files no_dump ssh-perms vim-helptags vim-spellfiles

rc_files: .vimrc .gvimrc .irbrc

# Most of these are optional.
dropbox_files: 
	if [ -d ~/Dropbox ]; then chmod -R u=rwX,g=rX,o=  ~/Dropbox; else true; fi
	if [ -d ~/Dropbox/Backups -a ! -d ~/Backups ]; then ln -s ~/Dropbox/Backups ~/Backups; else true; fi
	if [ -d ~/Dropbox/Documents -a ! -d ~/Documents ]; then ln -s ~/Dropbox/Documents ~/Documents; else true; fi
	if [ ! -h ~/.ssh/keys -a ! -e ~/.ssh/keys ]; then ln -s ~/Dropbox/Ssh/keys ~/.ssh/keys; fi
	if [ ! -h .ssh/config -a ! -f .ssh/config ]; then ln -s ~/Dropbox/Ssh/config ~/.ssh/config; fi

insync_files:
	if [ -d ~/bigboss1964@gmail.com ]; then chmod -R u=rwX,g=rX,o=  ~/bigboss1964@gmail.com; else true; fi

status:
	git status | $(PAGER)

pull:
	git pull origin

push:
	git push origin

.vimrc: .vim/vimrc
	$(LINK)

.gvimrc: .vim/gvimrc
	$(LINK)

# non version controlled (yet). Just make sure it exists.
.irbrc:
	touch .irbrc

ssh-perms:
		chmod -R u=rwX,g=,o= ~/.ssh/keys
		chmod 0700 ~/.ssh/config
		chmod 0700 ~/.ssh/authorized_keys
		chmod 0700 ~/.ssh/known_hosts

vim-helptags:
	if type vim >/dev/null 2>/dev/null; then \
		for _D in .vim/bundle/*/doc; do \
			echo "vim :helptags $$_D" ; \
			vim -e --cmd "helptags $$_D | q"; done; fi

vim-spellfiles:
	if type vim >/dev/null 2>/dev/null; then \
		for _F in .vim/wordlists/*.add; do \
			echo "vim :mkspell $${_F}.spl $$_F" ; \
			vim -e --cmd ":mkspell! $${_F}.spl $$_F | q"; done; fi

# stuff that we don't really want in a dump
no_dump:
	if [ -d ~/Dropbox ]; then $(NODUMP) ~/Dropbox ; else true; fi
	if [ -d ~/bigboss1964@gmail.com ]; then $(NODUMP) ~/bigboss1964@gmail.com ; else true; fi
	if [ -d ~/.cache ]; then $(NODUMP) ~/.cache ; else true; fi
	if [ -d ~/.dbus/session-bus ]; then $(NODUMP) ~/.dbus/session-bus ; else true; fi
	if [ -d ~/.m2/repository ]; then $(NODUMP) ~/.m2/repository ; else true; fi

.PHONY: status pull push dropbox_files insync_files ssh-perms vim-helptags no_dump

