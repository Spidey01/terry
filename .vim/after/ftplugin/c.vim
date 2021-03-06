call PreHandlerHook()

set formatoptions+=tcroqn
setl tabstop=4 shiftwidth=4 expandtab
if has("folding")
	setl foldmethod=syntax 
endif

if has("cindent")
	" modify cindent to understand my switch...case and paren style
	setl cinoptions+=g2,(0
	setl cinkeys-=0#
endif

" Ignore object files in filename completion
set wildignore+=*.o

" allow doxygen highlighting
set syntax=c.doxygen

call PostHandlerHook()

