#
# GNU Makefile to setup $HOME state
#

MKDIR = mkdir -p $@
LINK = ln -s $< $@
VIM_PLUGIN_LINK = sh -c "cd `dirname $@` && ln -s ../../$< `basename $<`"
HOSTNAME = `uname -n`

all: hosts tmp sw dropbox_dirs xdg_dirs rc_files vim_dirs

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

.sh/config.d/mutt: .sh/config.d
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

vim_dirs: .vim/bundle \
	.vim/bundle/nerdcommenter .vim/bundle/nerdtree \
	.vim/bundle/netlib \
	.vim/bundle/tlib_vim .vim/bundle/ttoc_vim .vim/bundle/viki_vim \
	.vim/bundle/vim-scratch \
	.vim/bundle/vim-fugitive

.vim/bundle: Dropbox/VimPlugins/vim-pathogen/autoload/pathogen.vim
	mkdir -p .vim/autoload
	cp $< .vim/autoload/
	$(MKDIR)

.vim/bundle/nerdcommenter: Dropbox/VimPlugins/nerdcommenter
	$(VIM_PLUGIN_LINK)

.vim/bundle/nerdtree: Dropbox/VimPlugins/nerdtree
	$(VIM_PLUGIN_LINK)

.vim/bundle/netlib: Dropbox/VimPlugins/netlib
	$(VIM_PLUGIN_LINK)

.vim/bundle/tlib_vim: Dropbox/VimPlugins/tlib_vim
	$(VIM_PLUGIN_LINK)

.vim/bundle/ttoc_vim: Dropbox/VimPlugins/ttoc_vim
	$(VIM_PLUGIN_LINK)

.vim/bundle/viki_vim: Dropbox/VimPlugins/viki_vim .vim/bundle/tlib_vim .vim/bundle/ttoc_vim
	$(VIM_PLUGIN_LINK)

.vim/bundle/vim-scratch: Dropbox/VimPlugins/vim-scratch
	$(VIM_PLUGIN_LINK)

.vim/bundle/vim-fugitive: Dropbox/VimPlugins/vim-fugitive
	$(VIM_PLUGIN_LINK)


.PHONY: status pull push .cache .config .local/share .pythonrc Desktop dls music pics Public vids hosts tmp sw .vim/bundle
