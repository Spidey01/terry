call PreHandlerHook()

setl tabstop=4 shiftwidth=4 noexpandtab
if has("folding")
	setl foldexpr=getline(v:lnum)[0]==\"\\t\"
	setl foldmethod=expr
endif

call PostHandlerHook()
