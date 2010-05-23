call PreHandlerHook()

set formatoptions+=tcroqn
setl tabstop=4 shiftwidth=4 expandtab

if has("folding")
	setl foldmethod=marker
	setl foldmarker={,}
	setl foldtext=substitute(getline(v:foldstart),'{.*','{...}',)
endif

call PostHandlerHook()
