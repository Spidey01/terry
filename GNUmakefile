#
# GNU Makefile to setup $HOME state
#

MKDIR = mkdir -p $@
LINK = ln -s $< $@
HOSTNAME = `uname -n`

# command to set the nodump attribute
NODUMP = chattr +d 

all: submodules rc_files no_dump ssh-perms vim-helptags vim-spellfiles

submodules:
	git submodule init
	git submodule update

rc_files: .vimrc .gvimrc .irbrc

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
	if [ -d ~/Insync ]; then $(NODUMP) ~/Insync ; else true; fi
	if [ -d ~/.cache ]; then $(NODUMP) ~/.cache ; else true; fi
	if [ -d ~/.dbus/session-bus ]; then $(NODUMP) ~/.dbus/session-bus ; else true; fi
	if [ -d ~/.m2/repository ]; then $(NODUMP) ~/.m2/repository ; else true; fi
	if [ -d ~/.npm ]; then $(NODUMP) ~/.npm ; else true; fi

.PHONY: submodules ssh-perms vim-helptags no_dump

