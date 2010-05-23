call PreHandlerHook()

set formatoptions+=tcroqn
setl tabstop=4 shiftwidth=4 expandtab

if has("folding")
	setl foldmethod=indent
endif

" Ignore class files in filename completion
set wildignore+=*.class

call PostHandlerHook()
