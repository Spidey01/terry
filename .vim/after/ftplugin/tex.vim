call PreHandlerHook()

setl fileformat=dos
setl tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" fixes gq from using c-keyword based indentation
set cinwords=""

" skip filename completion on these suckers
set wildignore+=*.aux,*.log,*.ilg

call PostHandlerHook()
