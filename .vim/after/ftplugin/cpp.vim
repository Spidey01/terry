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
	setl cinoptions+=g2,h2,(0,#1
	setl cinkeys-=0#
endif

if has("syntax")
	" allow doxygen highlighting
	set syntax=cpp.doxygen
endif

" Ignore object files in filename completion
set wildignore+=*.o

call PostHandlerHook()
