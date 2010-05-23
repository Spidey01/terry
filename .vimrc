" vim: set ai noet ts=4 sw=4 fdls=1 fdm=marker sm tags=$HOME/.vim/vimrc.tags :
"
" Terry M Poulin personal vimrc file
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    WARNING !!! 
"
" This file must have UNIX end of lines to avoid errors when starting
" under unix. Use the pdos2unix and punix2dos sh scripts to convert or
"
" perl -p -e 's/\n/\r\n/' inputfile > outputfile  # UNIX to DOS
" perl -p -e 's/\r\n/\n/' inputfile > outputfile  # DOS to UNIX
"
" on the command line or vim it self.
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Table of Contents
" |VARIABLES|			--- Global variables
" |SETTINGS|			---	Settings
"	|GENERAL|			---	General options
"	|INTERFACE|			---	Interface specific options
"	|FORMATS|			---	Configuration for various file formats
" |MACROS|				--- Macro instructions
" 	|ABBREVIATIONS|		--- Abbreviations for insert, command, or all modes
"	|AUTOCMDS|			---	Auto commands for calling format handler functions
"	|COMMANDS|			--- Ex commands
" 	|MAPS|				--- Key mappings
" 	|FUNCTIONS|			---	Global functions
" 		|HELPER|		--- Useful functions for general usage
"		|HANDLERS|		--- Handler functions for various file formats
" |PLUGINS|				--- Plugin specific configuration 
" 	|BuiltIn|			--- Options for built in plugin/syntax files/etc.
"   |CSApprox|			--- Color Scheme Approximate
"	|Taglist|			--- Tags file navigator plugin
"	|NERDTree|			--- Enhanced file system tree navigator
" |play|				--- Misc stuff, usually notes / code snippets
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preferences
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" *VARIABLES* {{{
" XXX Note that plugin specific variables belong in |PLUGINS|

	" a quick pair of constants for hostnames...
	" full hostname
	let g:Hostname = hostname()
	" short hostname
	let g:hostname = tolower(substitute(g:Hostname, '\..*', '', ''))
	
" !VARIABLES }}}

" *SETTINGS* {{{

	" Don't be VI compatible - Keep this at top of file !
	" Also skip loading .exrc and friends in the CWD.
	set nocompatible
	set noexrc
	" Set Vi compatibility options
	"
	" v = don't update the line more then needed          - like vi
	" $ = place a $ at end of a change, instead of update - like vi
	" y = . after a yank repeats the yank, not the insert - like vi
	" r = makes . after / behave as in vi (vim way sucks  - like vi)
	" u = undo behaves as in vi, use ^R to redo.
	set cpoptions+=v$yru

	" Set GUI Options options before loading other stuff
	"
	" c = use console dialogs for simple choices
	" i = use Vim icon if available
	" m = use menu bar
	set guioptions=cgim

	" autoselect, console dialogs, tabpages, icon, menubar, show grey menu
	" items, tearoff menu items, Toolbar, always right scrollbar.
	"set guioptions=aceimgtTrM
	

	" Kill visual bell
	set visualbell t_vb=


	" *GENERAL* {{{

		" Indentation settings (explicitly)
		set tabstop=8
		set shiftwidth=8
		set noexpandtab

		" Preferred file formats, ffs
		set fileformat=unix
		set fileformats=unix,dos,mac

		" Enable filetypes and plugins
		filetype plugin indent on 

		"Enable syntax related features
		if has("syntax")
			syntax on
		endif


		" this also makes vertically split windows more READABLE.
		" -> Thanks godlygeek
		set wrap

		" Allow keys to move to next logical line marker at EOL
		set whichwrap=b,s,h,l,<,>,[,],~

		" Allow backspacing over everything in insert mode
		set backspace=indent,eol,start


		" Make join commands smarter
		set joinspaces

		" Show matching symbols Vi style
		set showmatch
		set matchtime=3


		" highlight matched text when searching
		"if has('extra_search')
		"	set hlsearch
		"endif

		" Ignore case when searching unless it starts with a Capitol
		set ignorecase
		set smartcase


		" Use the system clipboard as the default register, '*'
		if has("clipboard")
			set clipboard=unnamed,exclude:cons\|linux
		endif


		" Allow names with some spaces in path, like when using gf
		"set isfname+=32


		" How to display tabs when list is on and expand tab is off
		set listchars=tab:\|\ 
		set nolist

	
		" Provide overrides for terminal type where the environment has
		" deviancies that vim can not correct for, so we get optimal values.
		if &term == 'rxvt' && g:hostname == 'dixie'
			" FreeBSDs rxvt-unicode has 88 colours by default.
			set t_Co=88
		elseif &term == 'screen'
			" Screen does ok at simulating 256col on my systems.
			set t_Co=256
		endif

		" Automatically change to directories if possible.
		if has("netbeans_intg") || has("sun_workshop")
			"set autochdir
		elseif has("autocmd")
			" Mimic the autochdir option with a function and an autocmd
			function! My_Autochdir()
				exec "cd %:p:h"
			endfunction
			"autocmd BufEnter * call My_Autochdir()
		endif

		" Set spell checker language
		if exists("+spell")
			set spelllang=en_us,en_gb,de
			set spellfile=~/.vim/wordlists/genwordlist.utf-8.add,~/.vim/wordlists/techwordlist.utf-8.add
			set spell
			" disable highlighting
			" XXX see |MAPS| for a mapping to toggle this highlighting
			set hl+=B:none,P:none,R:none,L:none
		endif


		" Show function prototypes when doing ins-completion
		set showfulltag

		" Settings for omni completion
		if exists("+omnifunc")
			set completeopt=menu,longest
			set infercase
			"Enable syntax file based omni completion when no other method is set
			if has("autocmd")
				autocmd Filetype *
				\	if &omnifunc == "" |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
			endif
		endif



	" !GENERAL }}}

	" *INTERFACE* {{{

		"load my default colour scheme
		colo none


		" Show status bar with file name e.t.c. 
		" 0 = never, 1 = if >= 2 window, 2 = always
		set laststatus=1

		"set :command line height in lines
		set cmdheight=1

		" Show % of file in status bar
		if has("cmdline_info")
			set ruler
		endif

		" Set tab menu 0=never, 1=when more then one, 2=always
		set showtabline=1

		" Set minimal length of line numbering
		set numberwidth=2

		" Allow split windows to shrink to this size
		if has("windows")
			set winminheight=0
		endif

		" Vim command line completion lists possible matches
		set wildmode=list:full

		" Start with mouse support off for all modes
		if has("gui_running")
			set mouse=
		endif

		" Hide mouse pointer when typing in text
		set mousehide

		" Set folding
		if has("folding")
			set foldlevelstart=99
			set foldcolumn=0
		endif

	" !INTERFACE }}}

" *FORMATS* {{{

		if has("autocmd")
	"	XXX Document based formats
			" make new.txt files dos/win friendly
			autocmd BufNewFile *.txt set ff=dos
			autocmd BufNewFile,BufRead *.txt call TextFileHandler()
			autocmd BufRead *.doc call DocFileHandler()
			autocmd BufRead *.pdf call PdfFileHandler()
			autocmd BufRead *.ps call PsFileHandler()		
			autocmd BufRead *.dvi call DviFileHandler()
			autocmd BufNewFile,BufRead *.outline call My_OutlineMode()
	"	XXX Image file based formats
			autocmd BufRead *.jpg,*.jpeg,*.png,*.tiff,*.bmp,*.gif
						\ call ImgFileHandler()
			autocmd BufRead *.xpm call XImgFileHandler()
	"	XXX Code based formats
			autocmd BufNewFile,BufRead *.c,*.h call CFileHandler()
			autocmd filetype cpp call CXXFileHandler()
			autocmd filetype cs call CSharpFileHandler()
			autocmd filetype html,xhtml call HtmlFileHandler()
	"	XXX for use with other programs
			autocmd filetype cvs,svn,git,bzr set autoindent
			autocmd BufNewFile,BufRead SConscript,SConfig set ft=python
		endif

		if has("folding")
			let g:perl_fold=1
			let g:perl_fold_blocks=1
			let g:php_folding=1
			let g:ruby_fold=1
			let g:sh_fold_enabled=4
			let g:tex_fold_enabled=1
			let javaScript_fold=1
		endif

" !FORMATS }}}

" !SETTINGS }}}

" *MACROS* {{{

	" *ABBREVIATIONS* {{{

		" unconditionally edit file with :E, as in ed
		cab E e!
		" unconditionally exit vim with :Q, as in ed
		cab Q qall!

		if exists("*strftime")
			iabbrev insert_date <c-r>=strftime("%Y-%m-%d T%H:%M:%S %Z")<cr>
		endif

		iabbrev teh the
		iabbrev swtich switch
 
	
	" !ABBREVIATIONS }}}

	" *AUTOCMDS* {{{

	
	" !AUTOCMDS }}}

	" *COMMANDS* {{{

		" Display the syn/hi group of the word under the cursor
		com! SynID echo synIDattr(synID(line("."), col("."), 1), "name") 

		" :Command to view diffthis against the last save.
		com! DiffOrig diffoff! | vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

		" :Command to copy everything for pasting into another app
		com! YankAll 1,$yank +
	
	" !COMMANDS }}}

	" *MAPS* {{{

		" Use ";" as an alias for ":" -> it makes life so much easier
		"nnoremap ; :
		" then make ":" behave like ";" would have behaved.
		"nnoremap : ;

		" make Y behave more logically
		nnoremap Y y$

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
		" make variants that do auto correction
		nnoremap [Z [s1z=
		nnoremap ]Z ]s1z=
		nnoremap Z= 1z=

		" toggle spelling highlights on/off
		nnoremap <leader>Z :set hl&<cr>
		nnoremap <leader>z :set hl+=B:none,P:none,R:none,L:none<cr>

		" swap words under cursor with \xp or gxp (where \ = <leader>
		" note: effecting the registers is intentional!
		nnoremap <silent> <leader>xp diWdWWP"2P
		nmap gxp <leader>xp

		" \date normal mode command  makes for "	-- g:myname YYYY-MM-DD"
		nnoremap <leader>date A<c-r>="\t-- ".g:myname.strftime(" %Y-%m-%d")<cr><esc>

		" allow a more natural style of line editing in :ex mode
		cnoremap <C-A> <Home>
		cnoremap <C-E> <End>
		cnoremap <C-F> <Right>
		cnoremap <C-B> <Left>
		cnoremap <Esc>b <S-Left>
		cnoremap <Esc>f <S-Right>
	
		" make useless shift+tab do auto completion -- great for XML !
		inoremap <S-Tab> <C-x><C-o>

	" !MAPS }}}

	" *FUNCTIONS* {{{
	"
	" XXX: Be sure to add ! to functions and commands in order to 
	" the definitions if this file is resourced after startup.


		" Make current file executable
		function! ChmodScript()
			silent! execute ":!chmod +x %"
		endfunction
		command! Chmod call ChmodScript()

		" ROT13 encode/decode the current file
		function! ROT13()
			<esc>ggvGg?
		endfunction


		" Helper function to prompt the user if editing or viewing is desired
		" returns 1 = view, 0 = edit
		function! ViewOrEdit()
			let l:prompt = input("View or edit % [view|edit]: ")
			if l:prompt[0] == 'v' || l:prompt[0] == 'V'
				return 1
			elseif l:prompt[0] == 'e' || l:prompt[0] == 'E'
				return 0
			endif
		endfunction


	" !FUNCTIONS }}}

	" *HANDLERS* {{{

		function! PreHandlerHook()
			setl autoindent 
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
			if has("folding")
				setl foldmethod=indent
			endif
			set fo+=tcrqn
			set autoindent
			" fixes gq from using c-keyword based indentation
			set cinwords=""

			call PostHandlerHook()
		endfunction


		function! DocFileHandler()
			call PreHandlerHook()

			if has("gui_running") ||  has("win32")
				!{abiword "%" || kword "%" || swriter "%"}  &
				q
			else
				r!antiword -tf  "%s" 
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

			if ViewOrEdit()
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

			if ViewOrEdit()
				if has("x11")
					!{xdvi "%" || kdvi "%" ||  "%"} &
					q
				elseif has("win32")
					!echo "Go look up how to open DVI on TexLive Win"
				endif
			else
				" depends on the dvi2tty program
				!dvi2tty -F'vim -c "setl ro fdl=99"  -' "%"
				q
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

			if ViewOrEdit()
				if has("x11")
					!xv "%" &
					q
				endif
			endif

			call PostHandlerHook()
		endfunction

	"	XXX Code based formats

		function! CFileHandler()
			call PreHandlerHook()
			
			set formatoptions+=tcroqn
			setl tabstop=8 shiftwidth=8 noexpandtab
			if has("folding")
				setl foldmethod=syntax 
			endif

			if has("cindent")
				" modify cindent to understand my switch...case and paren style
				setl cinoptions+=:2,=6,g2,(0
				setl cinkeys-=0#
			endif

			" Ignore object files in filename completion
			set wildignore+=*.o

			" allow doxygen highlighting
			set syntax=c.doxygen

			call PostHandlerHook()
		endfunction

		function! CXXFileHandler()
			call PreHandlerHook()

			set formatoptions+=tcroqn
			setl tabstop=4 shiftwidth=4 expandtab
			if has("folding")
				setl foldmethod=syntax 
			endif

			if has("cindent")
				" modify cindent to understand my switch...case / class member
				" access specifier / paren styles and not force #directives into
				" col 1
				setl cinoptions+=:2,=2,g2,h2,(0,#1
				setl cinkeys-=0#
			endif

			if has("syntax")
				" allow doxygen highlighting
				set syntax=cpp.doxygen
			endif

			" Ignore object files in filename completion
			set wildignore+=*.o

			call PostHandlerHook()
		endfunction

		function! CSharpFileHandler()
			call PreHandlerHook()

			set formatoptions+=tcroqn
			setl tabstop=4 shiftwidth=4 expandtab
			if has("folding")
				setl foldmethod=marker
				setl foldmarker={,}
				setl foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
			endif

			call PostHandlerHook()
		endfunction

		function! HtmlFileHandler()
			call PreHandlerHook()

			setl tabstop=2 shiftwidth=2 expandtab
			if has("folding")
				setl foldmethod=indent
			endif
			filetype indent on
			setl matchpairs+=<:>
			if exists("+omnifunc")	" think twice about using this with other langs
				imap </ </<c-x><c-o>
			endif

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
			setl autoindent 
			if has("smartindent")
				setl smartindent
			endif
			setl showmatch matchtime=3
			setl matchpairs+=(:),{:},[:],<:>
			if has("folding")
				" Fold by tabs
				"setl foldmethod=expr
				"setl foldexpr=getline(v:lnum)[0]==\"\\t\"
				" Fold by braces
				setl foldmethod=marker
				setl foldmarker={,}
			endif

			call PostHandlerHook()
		endfunction


	" !HANDLERS }}}

" !MACROS }}}

" *PLUGINS* {{{

	" *BuiltIn* {{{

		if has("syntax")
		" PHP Syntax
			" highlight HTML tags within strings
			let g:php_htmlInStrings=1
			" disable short tags
			let g:php_noShortTags=1
			" Do SQL highlighting inside strings
			let g:php_sql_query=1
			" Do HTML highlighting inside strings
			let g:php_htmlInStrings=1

		" Python Syntax
		
			let g:python_highlight_all=1

		" C/C++ Syntax
			" highlight GNU Compiler stuff
			let g:c_gnu=1
			" highlight preceding spaces before a tab as an error
			let g:c_space_errors=1
			let g:c_no_trail_space_error=1
			" use C syntax in *.h rather then C++ syntax
			let g:c_syntax_for_h=1

		" Java Syntax
			" Highlight all identifiers in java.lang.* 
			let g:java_highlight_java_lang_ids=1
		endif

	" !BuiltIn}}}


	" *CSApprox* {{{
	" Colour Scheme Approximator for console

		" skip if the terminal can't handle it
		if &t_Co < 88
			let g:CSApprox_loaded=1
		endif

		if !has("gui")	" only load plugin if gui support is available.
			let g:CSApprox_verbose_level=0
			let g:CSApprox_loaded=1
		else
			if &term == 'screen' && g:hostname == 'dixie' 
				let g:CSApprox_loaded=1
			" Other wise we likely want transparency, and CSApprox
			else
				let g:CSApprox_hook_none_post = 
							\['hi Normal  ctermbg=NONE ctermfg=NONE',
							\ 'hi NonText ctermbg=NONE ctermfg=NONE' ]
			endif
		endif

	" }}} !CSApprox

	" *Taglist* {{{
	" Exuberant Ctags capable tags browser window

		map <silent><leader>tl :TlistToggle<CR>
		let g:Tlist_Auto_Open=0
		let g:Tlist_GainFocus_On_ToggleOpen=1
		let g:Tlist_Enable_Fold_Column=0
		let g:Tlist_Exit_OnlyWindow=1
		let g:Tlist_Display_Prototype=1
		let g:Tlist_Show_Menu=1
		let g:Tlist_Use_Right_Window=1
		let g:Tlist_WinWidth=24
		let g:Tlist_Inc_WinWidth=0
		if g:hostname == 'sal1600'
			let g:Tlist_Ctags_Cmd='C:/DevFiles/Tools/ctags58/ctags.exe'
		endif
	" !Taglist }}}

	" *NERDTree* {{{
	" A very nerdy file system tree browser window

		map <silent><leader>nt :NERDTreeToggle<CR>
		let g:NERDTreeWinPos="right"
		let g:NERDTreeWinSize=24

	" !NERDTree }}}

" !PLUGINS }}}

" *play* {{{

" !play }}}

"let g:did_install_default_menus = 1
