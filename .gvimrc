" vim: set ff=unix ai si noet ts=4 sw=4 fdls=1 fdm=marker wrap tw=0 sm mat=3 spell tags=$HOME/.vim/vimrc.tags :
"
" Terry M Poulin personal gvimrc file
"
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
if g:hostname == "dixie"
	let g:none_colormode		 = 'dark'
endif
let g:none_usestyles         = 1
let g:none_usecolorimports   = 1

" Kill the dang visual bell if GUI is running!!!!
set novisualbell

" No ficken breaking cursor
" Also keep it in block mode
if !has("win32")
	"set guicursor+=a:block,a:blink0
endif

" Use mouse in all modes when using the GUI
set mouse=ar

" Right click menu lists correction options when spell is set
set mousemodel=popup_setpos

" Make mouse pointer an I-Beam in insert mode like most other programs
if has("mouseshape")
	set mouseshape=i:beam
endif

" X11: Specifics for GVim
if has("x11")
	set guifont=Andale\ Mono\ 10

" WINDOWS: Specifics for GVim
elseif has("win32")
	if g:hostname == 'sal1600'
		set guifont=Droid_Sans_Mono:h10:cANSI 
	endif
	set lines=35
	set columns=80

endif

" adjust nerd tree options
let g:Tlist_Inc_Winwidth=1
let g:Tlist_WinHeight=7
let g:Tlist_WinWidth=25
let g:Tlist_Show_Menu=1

