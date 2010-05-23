call PreHandlerHook()

setl tabstop=4 shiftwidth=4 expandtab

if has("folding")
	" This doesn't work
	setl foldmethod=syntax
endif

call PostHandlerHook()
