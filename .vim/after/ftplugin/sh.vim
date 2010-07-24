call PreHandlerHook()

setl tabstop=4 shiftwidth=4 expandtab

if has("folding")
	let g:sh_fold_enabled=4
endif

call PostHandlerHook()
