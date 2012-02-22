call PreHandlerHook()

" I don't remember where I got this and don't have it anymore.
" Now using othree's xml.vim ftplugin
"runtime ftplugin/xml-sgml.vim

setl tabstop=2 shiftwidth=2 expandtab
if has("folding")
	let g:xml_syntax_folding = 1
	setl foldmethod=syntax 
endif

call PostHandlerHook()
