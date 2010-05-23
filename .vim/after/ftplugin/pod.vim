call PreHandlerHook()

" insert abbreviations so we can use space to complete =directives
" with an argument, and <cr> to complete =directives without any.

" this allows our iab's to work
setl isk+==
iab <buffer> =i =item
iab <buffer> =f =for
iab <buffer> =be =begin
iab <buffer> =ba =back
iab <buffer> =e =end
iab <buffer> =c =cut<cr>
iab <buffer> =p =pod<cr>
iab <buffer> =o =over

call PostHandlerHook()
