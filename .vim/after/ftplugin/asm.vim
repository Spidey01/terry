call PreHandlerHook()

if has("folding")
	setl foldmethod=indent
endif

" Ignore object files in filename completion
set wildignore+=*.o

call PostHandlerHook()
