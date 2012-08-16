#
# GNU Makefile to setup $HOME state
#

MKDIR = mkdir -p $@
LINK = ln -s $< $@
HOSTNAME = `uname -n`


all: rc_files

rc_files: .vimrc .gvimrc .pythonrc .irbrc


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

.PHONY: status pull push vim-helptags

