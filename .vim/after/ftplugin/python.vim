call PreHandlerHook()

setl tabstop=4 shiftwidth=4 expandtab
if has("folding")
	setl foldmethod=marker
endif
setl keywordprg=pydoc

call PostHandlerHook()
