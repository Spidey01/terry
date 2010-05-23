call PreHandlerHook()

setl tabstop=2 shiftwidth=2 expandtab

if has("folding")
	setl foldmethod=indent
endif

" Make sure the indent script is turned on
filetype indent on

setl matchpairs+=<:>
if exists("+omnifunc")
	imap </ </<c-x><c-o>
endif


call PostHandlerHook()
