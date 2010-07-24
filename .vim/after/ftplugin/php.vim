call PreHandlerHook()

setl tabstop=4 shiftwidth=4 expandtab

if has("folding")
	let g:php_folding=1
endif

call PostHandlerHook()
