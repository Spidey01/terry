call PreHandlerHook()

if has("syntax") && &t_Co > 2 
	syntax on
endif

" Extra insurance against using a non-unix format vimrc on unix
" -> vim got pissed back in the 6.x days.
setl fileformat=unix
setl tabstop=4 shiftwidth=4 noexpandtab

if has("folding")
	setl foldmethod=marker
endif

call PostHandlerHook()
