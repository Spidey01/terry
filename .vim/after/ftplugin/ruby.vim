call PreHandlerHook()

setl tabstop=2 shiftwidth=2 expandtab

filetype indent on

setl keywordprg=ri

if has("folding")
	let g:ruby_fold=1
endif

call PostHandlerHook()
