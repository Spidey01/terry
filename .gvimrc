" vim: set ff=unix ai si noet ts=4 sw=4 fdls=1 fdm=marker wrap tw=0 sm mat=3 spell tags=$HOME/.vim/vimrc.tags :
"
" Terry M Poulin personal gvimrc file
"
"	$Id$:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    WARNING !!! 
" This file must have UNIX end of lines to avoid errors when starting
" under unix. Use the pdos2unix and punix2dos sh scripts to convert or
"
" perl -p -e 's/\n/\r\n/' inputfile > outputfile  # UNIX to DOS
" perl -p -e 's/\r\n/\n/' inputfile > outputfile  # DOS to UNIX
"
" on the command line or vim it self.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set options for my gui colo
let g:none_usestyles         = 1
let g:none_usecolorcomments  = 1
let g:none_usecolorimports   = 1

"Enable syntax highlighting
syntax on

" Kill the dang visual bell if GUI is running!!!!
set novisualbell

" X11: Specifics for GVim
if has("x11")
	"I love this font!!
	set guifont=Terminus\ 14
	"set lines=40
	"set columns=80

" WINDOWS: Specifics for GVim
elseif has("win32")
	set guifont=Fixedsys:h11:cANSI
	set lines=25
	set columns=80

endif

" adjust nerd tree options
let g:Tlist_Inc_Winwidth=1
let g:Tlist_WinHeight=7
let g:Tlist_WinWidth=25
let g:Tlist_Show_Menu=1

