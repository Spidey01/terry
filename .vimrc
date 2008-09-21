" Terry M Poulin personal vimrc file
" vim: set ff=unix ai si noet ts=4 sw=4 fdls=1 fdm=marker wrap tw=0 sm mat=3 spell tags=$HOME/.vim/vimrc.tags :
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Table of Contents
" |SETTINGS|			---	Settings
"	|GENERAL|			---	General options
"	|FORMATS|			---	Configuration for various file formats
"		|AUTOCMDS|		---	Auto commands for calling format handler functions
"		|HANDLERS|		--- Handler functions for various file formats
"	|INTERFACE|			---	Interface specific settings
" |BINDS|				---	Common Bindings 
" 	|FUNCTIONS|			---	Global helper functions
"	|COMMANDS|			--- Normal mode commands
" 	|MAPS|				--- Key mappings
" |PLUGINS|				--- Plugin specific configuration 
"	|Taglist|
"	|NERDTree|
" |play|				--- Misc stuff, usually notes / code snippets
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preferences
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" *SETTINGS* {{{

" *GENERAL* {{{

	" Don't be VI compatible - Keep this at top of file !
	" Also skip .exrc -> I use it for Vi
	set nocompatible
	set noexrc

	" Ignore case when searching unless it starts with a Capitol
	set ignorecase
	set smartcase

	" Use the system clipboard as the default register, '*'
	set clipboard=unnamed

	" Make join commands smarter
	set joinspaces

	" Kill visual bell
	set visualbell t_vb=

	" Allow names with some spaces in path, like when using gf
	set isfname+=32

	" Show matching symbols Vi style
	set showmatch
	set matchtime=3
	set matchpairs=(:),{:},[:],<:>

	" How to display tabs when list is on and expand tab is off
	set listchars=tab:\|\ 
	set nolist

	" Physical word wrapping
	set textwidth=80

	" Allow backspacing over everything in insert mode
	set backspace=indent,eol,start

	" Allow keys to move to next logical line marker at EOL
	set whichwrap=b,s,h,l,<,>,[,],~

	" Set folding
	set foldlevelstart=99
	set foldmethod=indent

	" Indentation settings (explictly)
	set tabstop=8
	set shiftwidth=8
	set noexpandtab

	" Set minimal length of line numbering
	set numberwidth=2

	" Set tab menu 0=never, 1=when more then one, 2=always
	set showtabline=1

	" Preferred file formats, ffs
	set fileformat=unix
	set fileformats=unix,dos,mac


	" Show status bar with file name e.t.c. 
	" 0 = never, 1 = if >= 2 window, 2 = always
	set laststatus=2

	" Show % of file in status bar
	set ruler

	" Vim command line completion lists possible matches
	set wildmode=list:full

	" Start with mouse support in all modes
	set mouse=a
	" Hide mouse pointer when typing in text
	set mousehide

	" Allow split windows to shrink to this size
	set winminheight=0

	" Set spell checker language
	if exists("+spell")
		set spelllang=en_us,en_gb,de
	endif

	" Show function prototypes when doing ins-completion
	set showfulltag

	" Settings for omni completion
	if exists("+omnifunc")
		set completeopt=menu
		set infercase
		"Enable syntax file based omni completion when no other method is set
		if has("autocmd")
			autocmd Filetype *
			\	if &omnifunc == "" |
			\		setlocal omnifunc=syntaxcomplete#Complete |
			\	endif
		endif
	endif

	" Allow cursor to move virtually in =mode or =onemore past the EOL
	"set virtualedit=onemore

	" UNIX: Include system tags file
	if has("unix")
		set tags+=~/.vim/systags
	endif

	" Enable filetypes and plugins
	filetype on
	filetype plugin on
	filetype indent off

	"Enable syntax highlighting
	if &t_Co > 2 || has("gui_running")
		syntax on
	endif

	" Automatically change to directories if possible.
	if has("netbeans_intg") || has("sun_workshop")
		set autochdir
	elseif has("autocmd")
		" Mimic the autochdir option with a function and an autocmd
		function! My_Autochdir()
			exec "cd %:p:h"
		endfunction
		autocmd BufEnter * call My_Autochdir()
	endif

" !GENERAL }}}

" FORMATS {{{

" AUTOCMDS {{{



	if has("autocmd")
"	XXX Document based formats
		" make *.txt dos/win friendly
		autocmd BufNewFile *.txt set ff=dos
		autocmd BufNewFile,BufRead *.txt call TextFileHandler()
		autocmd BufNewFile *.rtf call RtfFileHandler()
		autocmd BufRead *.rtf call RtfFileHandler()
		autocmd BufRead *.doc call DocFileHandler()
		autocmd BufRead *.pdf call PdfFileHandler()
		autocmd BufRead *.ps call PsFileHandler()		
		autocmd BufRead *.dvi call DviFileHandler()
		autocmd BufNewFile,BufRead *.outline call My_OutlineMode()
"	XXX Image file based formats
		autocmd BufRead *.jpg,*.jpeg,*.png,*.tiff,*.bmp,*.gif call ImgFileHandler()
		autocmd BufRead *.xpm call XImgFileHandler()
"	XXX Code based formats
		autocmd BufNewFile,BufRead *.ada call AdaFileHandler()
		autocmd BufNewFile,BufRead *.asm call AsmFileHandler()
		autocmd BufNewFile,BufRead *.c,*.h call CFileHandler()
		autocmd BufNewFile,BufRead *.css call CSSFileHandler()
		autocmd BufNewFile,BufRead *.cc,*.cxx,*.cpp,*.hh,*.hpp,*.hxx call CXXFileHandler()
		autocmd BufNewFile,BufRead *.d call DFileHandler()
		autocmd BufNewFile,BufRead *.el call ELispFileHandler()
		autocmd BufNewFile,BufRead *.html,*.xhtml call HtmlFileHandler()
		autocmd BufNewFile,BufRead *.java call JavaFileHandler()
		autocmd BufNewFile,BufRead *.js call JavaScriptFileHandler()
		autocmd BufNewFile,BufRead *.lua call LuaFileHandler()
		autocmd BufNewFile,BufRead Makefile,Makefile.*,*.mk call MakefileFileHandler()
		autocmd BufNewFile,BufRead *.pl,*.plx,*.pm,*.ppm call PerlFileHandler()
		autocmd BufNewFile,BufRead *.php,*.php? call PhpFileHandler()
		autocmd BufNewFile,BufRead *.py call PythonFileHandler()
		autocmd BufNewFile,BufRead *.rb call RubyFileHandler()
		autocmd BufNewFile,BufRead *.scm call SchemeFileHandler()
		autocmd BufNewFile,BufRead *.sh,*.ksh,*.pdksh,*.ksh*,*.zsh,*.bash call ShellFileHandler()
		autocmd BufNewFile,BufRead *.sql call SqlFileHandler()
		autocmd BufNewFile,BufRead *.tex call TexFileHanlder()
		autocmd BufNewFile,BufRead *.t call TroffFileHandler
		autocmd BufNewFile,BufRead *.vim call VimFileHanlder()
		autocmd BufNewFile,BufRead *.vb,*.vb? call VisualBasicFilHandler()
"	XXX for use with other programs
		autocmd BufNewFIle,BUfRead *.tmp call My_KNodeConfig()
	endif

" !AUTOCMDS }}}

" HANDLERS {{{

	function! PreHandlerHook()
		setl autoindent smartindent
		if exists("+spell")
			setl spell
		endif
	endfunction
	function! PostHandlerHook()
	endfunction

"	XXX Document based formats
	function! TextFileHandler()
		call PreHandlerHook()

		" turn off some stuff when viewing Vim help files
		if &ft == "help"
			if exists("+spell")
				setl nospell
			endif
		endif
		setl fdm=expr
		set fo=tqna

		call PostHandlerHook()
	endfunction

	"function! RtfFileHandler(1)
	function! RtfFileHandler()
		call PreHandlerHook()

		let l:prompt = input("View or edit % [yes|no]?: ")
		if l:prompt=="y" || l:prompt=="yes" || l:prompt=="Y" || l:prompt=="YES"
			!{abiword "%" || wordpad.exe "%" || kword "%" || swriteer "%"}  &
			q
		endif

		call PostHandlerHook()
	endfunction

	function! DocFileHandler()
		call PreHandlerHook()

		if has("gui_running") || has("x11") || has("win32")
			!{abiword "%" || kword "%" || swriteer "%"}  &
			q
		else
			echo "You didn't setup antiword"
		endif
		call PostHandlerHook()
	endfunction

	function! PdfFileHandler()
		call PreHandlerHook()

		if has("x11")
			!{evince "%" || kpdf "%" || xpdf "%"} &
			q
		elseif has("win32")
			!"Foxit Reader.exe" "%" &
			q
		else
			echo "No text dump program setup available...."
		endif

		call PostHandlerHook()
	endfunction

	function! PsFileHandler()
		call PreHandlerHook()

		let l:prompt = input("View or edit % [yes|no]?: ")
		if l:prompt=="y" || l:prompt=="yes" || l:prompt=="Y" || l:prompt=="YES"
			if has("x11")
				!{evince "%" || kpdf "%" || xpdf "%"} &
				q
			elseif has("win32")
				echo "Whats the ps viewer?"
			else
				echo "No text dump program installed...."
			endif
		endif

		call PostHandlerHook()
	endfunction
		
	function! DviFileHandler()
		call PreHandlerHook()

		let l:prompt = input("View % in Vim [yes|no]?: ")
		if l:prompt=="y" || l:prompt=="yes" || l:prompt=="Y" || l:prompt=="YES"
			" depends on the dvi2tty program
			!dvi2tty -F'vim -c "setl ro fdl=99"  -' "%"
			q
		else
			if has("x11")
				!{xdvi "%" || kdvi "%" ||  "%"} &
				q
			elseif has("win32")
				!echo "Go look up how to open DVI on TexLive Win"
			endif
		endif

		call PostHandlerHook()
	endfunction

"	XXX Image file based formats
	function! ImgFileHandler()
		call PreHandlerHook()

		if has("x11")
			!xv "%" &
			q
		elseif has("win32")
			!\%systemroot\%\system32\rundll32.exe \%systemroot\%\system32\shimgvw.dll,imageview_fullscreen  "%" || \%systemroot\%\system32\mspaint.exe "%"
			q
		else
			echo "no external viewer for text mode set...."
		endif

		call PostHandlerHook()
	endfunction

	function! XImgFileHandler()
		call PreHandlerHook()

		let l:prompt = input("View or edit % [yes|no]?: ")
		if l:prompt=="y" || l:prompt=="yes" || l:prompt=="Y" || l:prompt=="YES"
			if has("x11")
				!xv "%" &
				q
			endif
		endif

		call PostHandlerHook()
	endfunction

"	XXX Code based formats
	function! AdaFileHandler()
		call PreHandlerHook()

		call PostHandlerHook()
	endfunction

	function! AsmFileHandler()
		call PreHandlerHook()

		call PostHandlerHook()
	endfunction

	function! CFileHandler()
		call PreHandlerHook()
		
		setl tabstop=8 shiftwidth=8 noexpandtab
		setl foldmethod=syntax foldcolumn=1
		setl matchpairs-=<:>
		" highlight GNU Compiler stuff
		let c_gnu=1
		" highlight preceding spaces before a tab as an error
		let c_space_errors=1
		let c_no_trail_space_error=1
		" use C syntax in *.h rather then C++ syntax
		let c_syntax_for_h=1

		call PostHandlerHook()
	endfunction

	function! CSSFileHandler()
		call PreHandlerHook()

		setl tabstop=5 shiftwidth=5 expandtab
		setl foldmethod=indent

		call PostHandlerHook()
	endfunction

	function! CXXFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 expandtab
		setl foldmethod=syntax foldcolumn=1
		setl matchpairs-=<:>

		call PostHandlerHook()
	endfunction

	function! DFileHandler()
		call PreHandlerHook()
		call PostHandlerHook()
	endfunction

	function! ELispFileHandler()
		call PreHandlerHook()
		call PostHandlerHook()
	endfunction

	function! HtmlFileHandler()
		call PreHandlerHook()

		setl tabstop=2 shiftwidth=2 expandtab
		setl foldmethod=indent
		filetype indent on
		if exists("+omnifunc")	" think twice about using this with other langs
			imap </ </<c-x><c-o>
		endif

		call PostHandlerHook()
	endfunction

	function! JavaFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 expandtab
		setl foldmethod=indent
		setl matchpairs-=<:>
		if exists("+spell")
			setl nospell " FUBAR in Java
		endif
		" Highlight all identifiers in java.lang.* 
		let java_highlight_java_lang_ids=1

		call PostHandlerHook()
	endfunction

	function! JavaScriptFileHandler()
		call PreHandlerHook()
		call PostHandlerHook()
	endfunction

	function! LuaFileHandler()
		call PreHandlerHook()
		call PostHandlerHook()
	endfunction

	function! MakefileFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 noexpandtab
		setl foldmethod=indent

		call PostHandlerHook()
	endfunction

	function! PerlFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 noexpandtab
		setl foldmethod=indent
		setl matchpairs-=<:>
		let perl_fold=1
		" perldoc is to complex imho for keywordprg w/o a wrapper script imho

		call PostHandlerHook()
	endfunction

	function! PhpFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 expandtab
		setl foldmethod=indent
		setl matchpairs-=<:>
		" highlight HTML tags within strings
		let php_htmlInStrings=1
		" disable short tags
		let php_noShortTags=1
		" allow code folding for classes and functions!
		let php_folding=1

		call PostHandlerHook()
	endfunction

	function! PythonFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 expandtab
		setl foldmethod=indent
		setl matchpairs-=<:>
		setl keywordprg=pydoc
		let python_highlight_all=1

		call PostHandlerHook()
	endfunction

	function! RubyFileHandler()
		call PreHandlerHook()

		setl tabstop=2 shiftwidth=2 expandtab
		setl foldmethod=syntax
		setl matchpairs-=<:>
		filetype indent on
		setl keywordprg=ri
		let ruby_fold=1

		call PostHandlerHook()
	endfunction

	function! SchemeFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 expandtab
		setl foldmethod=syntax
		setl matchpairs-=<:>
		if exists("+spell")
			setl nospell " FUBAR in Scheme
		endif
		call PostHandlerHook()
	endfunction

	function! ShellFileHandler()
		call PreHandlerHook()

		setl tabstop=4 shiftwidth=4 expandtab
		setl foldmethod=indent
		setl matchpairs-=<:>

		call PostHandlerHook()
	endfunction

	function! SqlFileHandler()
		call PreHandlerHook()

		setl tabstop=2 shiftwidth=2 expandtab
		setl matchpairs-=<:>

		call PostHandlerHook()
	endfunction

	function! TexFileHanlder()
		call PreHandlerHook()

		setl fileformat=dos
		setl tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
		setl foldmethod=indent
		setl matchpairs-=<:>
		"  syntax-based folding of parts, chapters, sections, subsections, etc
		let g:tex_fold_enabled=1

		call PostHandlerHook()
	endfunction

	function! TroffFileHandler()
		call PreHandlerHook()

		call PostHandlerHook()
	endfunction

	function! VimFileHanlder()
		call PreHandlerHook()

		setl fileformat=unix
		setl tabstop=4 shiftwidth=4 noexpandtab
		setl foldmethod=marker
		setl matchpairs-=<:>

		call PostHandlerHook()
	endfunction

	function! VisualBasicFilHandler()
		call PreHandlerHook()

		setl fileformat=unix
		setl matchpairs-=<:>

		call PostHandlerHook()
	endfunction

"	XXX for use with other programs
	" Settings for outlining ideas
	function! My_OutlineMode()
		call PreHandlerHook()

		setl tabstop=8 shiftwidth=8 noexpandtab
		setl listchars =tab:\|\ " Mark \t's with |'s
		setl list
		if exists("+spell")
			setl spell
		endif
		setl autoindent smartindent
		setl showmatch matchtime=3
		setl matchpairs+=(:),{:},[:],<:>
		" Fold by tabs
		"setl foldmethod=expr
		"setl foldexpr=getline(v:lnum)[0]==\"\\t\"
		" Fold by braces
		setl foldmethod=marker
		setl foldmarker={,}

		call PostHandlerHook()
	endfunction

	" For the .tmp files created by knode
	function! My_KNodeConfig()
		call PreHandlerHook()

		setl textwidth=0 wrap
		if exists("+spell")
			setl spell
		endif
		setl autoindent smartindent
		setl foldmethod=indent
		set ft=mail

		call PostHandlerHook()
	endfunction

" !HANDLERS }}}

" !FORMATS }}}

" *INTERFACE* {{{


	"set :command line height in lines
	if has("gui_running")
		set cmdheight=2
	else
		set cmdheight=1
	endif


	" GUI: Set options mainly used for for GVim 

	" autoselect, console dialogs, tabpages, icon, menubar, show grey menu
	" items, tearoff menu items, Toolbar, always right scrollbar.
	set guioptions=aceimgtTr

	" Right click menu lists correction options when spell is set
	set mousemodel=popup_setpos

	" Make mouse pointer an I-Beam in insert mode like most other programs
	set mouseshape=i:beam


	if has("gui_running")
		" Kill the dang visual bell if GUI is running!!!!
		set novisualbell
	endif
	
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

	function! SetGuiColo()
		if exists("*strftime")
			let s:random = strftime("%S")
		else " fall through to the else
			let s:random = 61
		endif

		if s:random < 2
			colo ron
			let g:currentcolo = 'ron'
		elseif s:random < 4
			colo candycode
			let g:currentcolo = 'candycode'
		elseif s:random < 6
			colo silent
			let g:currentcolo = 'silent'
		elseif s:random < 8
			colo default
			let g:currentcolo = 'default'
		elseif s:random < 12
			colo denim
			let g:currentcolo = 'denim'
		elseif s:random < 14
			colo midnight2
			let g:currentcolo = 'midnight2'
		elseif s:random < 16
			colo hhazure
			let g:currentcolo = 'hhazure'
		elseif s:random < 18
			colo rootwater
			let g:currentcolo = 'rootwater'
		elseif s:random < 20
			colo nightshimmer
			let g:currentcolo = 'nightshimmer'
		elseif s:random < 22
			colo murphy
			let g:currentcolo = 'murphy'
		elseif s:random < 24
			colo coffee
			let g:currentcolo = 'coffee'
		elseif s:random < 26
			colo professional
			let g:currentcolo = 'professional'
		elseif s:random < 28
			colo sf
			let g:currentcolo = 'sf'
		elseif s:random < 30
			colo my
			let g:currentcolo = 'my'
		elseif s:random < 32
			colo vcbc
			let g:currentcolo = 'vcbc'
		elseif s:random < 34
			colo gobo
			let g:currentcolo = 'gobo'
		elseif s:random < 36
			colo metacosm
			let g:currentcolo = 'metacosm'
		elseif s:random < 38
			colo blackboard
			let g:currentcolo = 'blackboard'
		elseif s:random < 40
			colo billw
			let g:currentcolo = 'billw'
		elseif s:random < 42
			colo dusk
			let g:currentcolo = 'dusk'
		elseif s:random < 44
			colo desert
			let g:currentcolo = 'desert'
		elseif s:random < 46
			colo evening
			let g:currentcolo = 'evening'
		elseif s:random < 48
			colo golden
			let g:currentcolo = 'golden'
		elseif s:random < 50
			colo chela_light
			let g:currentcolo = 'chela_light'
		elseif s:random < 52
			colo camo
			let g:currentcolo = 'camo'
		elseif s:random < 54
			colo developer
			let g:currentcolo = 'developer'
		elseif s:random < 56
			colo neon
			let g:currentcolo = 'neon'
		elseif s:random < 58
			colo chlordane
			let g:currentcolo = 'chlordane'
		elseif s:random < 60
			colo shine
			let g:currentcolo = 'shine'
		else
			colo default
		endif
	endfunction

	function! SetConsoleColo()
		let s:random = strftime("%S")

		if exists("*strftime")
			let s:random = strftime("%S")
		else " fall through to the else
			let s:random = 61
		endif

		if s:random < 2
			colo astronaut
			let g:currentcolo = 'astronaut'
		elseif s:random < 4
			colo redblack
			let g:currentcolo = 'redblack'
		elseif s:random < 6
			colo default
			let g:currentcolo = 'default'
		elseif s:random < 8
			colo golden
			let g:currentcolo = 'golden'
		elseif s:random < 12
			colo candycode
			let g:currentcolo = 'candycode'
		elseif s:random < 14
			colo murphy
			let g:currentcolo = 'murphy'
		elseif s:random < 16
			colo my
			let g:currentcolo = 'my'
		elseif s:random < 18
			colo c
			let g:currentcolo = 'c'
		elseif s:random < 20
			colo elflord
			let g:currentcolo = 'elflord'
		elseif s:random < 22
			colo relaxedgreen
			let g:currentcolo = 'relaxedgreen'
		elseif s:random < 24
			colo astronaut
			let g:currentcolo = 'astronaut'
		elseif s:random < 26
			colo redblack
			let g:currentcolo = 'redblack'
		elseif s:random < 28
			colo default
			let g:currentcolo = 'default'
		elseif s:random < 30
			colo golden
			let g:currentcolo = 'golden'
		elseif s:random < 32
			colo candycode
			let g:currentcolo = 'candycode'
		elseif s:random < 34
			colo elflord
			let g:currentcolo = 'elflord'
		elseif s:random < 36
			colo c
			let g:currentcolo = 'c'
		elseif s:random < 38
		elseif s:random < 40
		elseif s:random < 42
			colo relaxedgreen
			let g:currentcolo = 'relaxedgreen'
		elseif s:random < 44
			colo redblack
			let g:currentcolo = 'redblack'
		elseif s:random < 46
			colo default
			let g:currentcolo = 'default'
		elseif s:random < 48
			colo candycode
			let g:currentcolo = 'candycode'
		elseif s:random < 50
			colo golden
			let g:currentcolo = 'golden'
		elseif s:random < 52
			colo relaxedgreen
			let g:currentcolo = 'relaxedgreen'
		elseif s:random < 54
			colo astronaut
			let g:currentcolo = 'astronaut'
		elseif s:random < 56
			colo my
			let g:currentcolo = 'my'
		elseif s:random < 58
			colo astronaut
			let g:currentcolo = 'astronaut'
		elseif s:random < 60
			colo murphy
			let g:currentcolo = 'murphy'
		else
			colo default
		endif

	endfunction

	" XXX make this a function to operate on a  list of colo
	if has("gui_running")
		call SetGuiColo()
	else
		call SetConsoleColo()
	endif


" !INTERFACE }}}

" !SETTINGS }}}

" *FUNCTIONS* {{{

" XXX: Be sure to add ! to functions and commands in order to overwrite
" the definitions if this file is resourced after startup.


" Make current file executable
function! ChmodScript()
	silent! execute ":!chmod +x %"
endfunction
command! Chmod call ChmodScript()

" ROT13 encode/decode the current file
function! ROT13()
	<esc>1GvGg?
endfunction

" !FUNCTIONS }}}


" *KEYS* {{{

"""" WARNING !!!
"""" NEVER MAP THE BACKSPACE KEY OR A MODIFIER

	" Use ";" as an alias for ":" -> it makes life so much easier
	nnoremap ; :

	" show more data when we ask for a line count
	nnoremap <C-g> <C-g>2<C-g>

	" clear search highlighting when redrawing the screen
	nnoremap <silent> <C-l> :nohl<CR><C-l>

	" Make Escape toggle normal/insert mode -> I don't like this!
	"nnoremap <silent> <esc> :startinsert<CR>
	
	" Combine [s and ]s with z= 
	" (e.g. move to miss spelled word in direction and get suggestions)
	nnoremap [z [sz=
	nnoremap ]z ]sz=

	" swap words under cursor with \xp or \gw (where \ = <leader>
	noremap <silent> <leader>xp "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l> 
	noremap <silent> <leader>gw <leader>xp

	" Use emacs style movement commands in insert mode
	" XXX: these redine Vim maps, ctrl-a => useless, ctrl-e => useful
	"inoremap <c-a> <esc>I
	"inoremap <c-e> <esc>A

	" F1 toggles spell checking for this buffer
	if exists("+spell")
		inoremap <F1> <esc>:set spell! <bar> set spell?<CR>i
		nnoremap <F1> <esc>:set spell! <bar> set spell?<CR>
	endif

	" F2 toggles  line numbers
	nnoremap <F2> :set number! <bar> set number?<CR>
	inoremap <F2> <esc>:set number! <bar> set number?<CR>i

	" F3 turns on  auto indentations
	nnoremap <F3> :set smartindent autoindent<CR>
	inoremap <F3> <esc>:set smartindent autoindent<CR>i

	" XXX make this toggle the nerd tree plugin
	" F5 launches file manager in the current directory
	nnoremap <F5> :OPEN %:p:h<CR>
	inoremap <F5> <esc>:OPEN %:p:h<CR>i


" !KEYS }}}

" *PLUGINS* {{{

" Taglist* {{{

	map <silent><leader>tl :TlistToggle<CR>
	let g:Tlist_Auto_Open=0
	let g:Tlist_GainFocus_On_ToggleOpen=1
	let g:Tlist_Enable_Fold_Column=0
	let g:Tlist_Exit_OnlyWindow=1
	let g:Tlist_Display_Prototype=1
	let g:Tlist_Show_Menu=1
	if !has("gui_running")
		let g:Tlist_Inc_Winwidth=0
		let g:Tlist_WinHeight=7
		let g:Tlist_WinWidth=15
	endif

" !Taglist }}}

" *NERDTree* {{{

" !NERDTree }}}

" !PLUGINS }}}



""""" *play* {{{
" Beautify omnicompletion popup
"highlight Pmenu guifg=white guibg=blue ctermfg=white ctermbg=blue    

" Fold paragraphs
"set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1

	if exists("*strftime")
		iabbrev insert_date <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
	endif

	iabbrev teh the
	iabbrev swtich switch

""""" !play }}}
