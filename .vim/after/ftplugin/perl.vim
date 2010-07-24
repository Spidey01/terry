call PreHandlerHook()

setl formatoptions+=tcrqn
setl tabstop=4 shiftwidth=4 expandtab

if has("folding")
	let g:perl_fold=1
	let g:perl_fold_blocks=1
endif

call PostHandlerHook()
