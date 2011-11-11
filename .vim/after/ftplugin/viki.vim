call PreHandlerHook()

setl tabstop=4 shiftwidth=4 softtabstop=4 expandtab autoindent nonumber

" My viki files tend to accululate enough structured information that using
" line numbers in commands is sometimes highly effective.
set nu

" I find it easier to begin with all folds slammed shut in a viki file
set foldlevel=0

" mapping to promote (less *) a heading; in emacs org-mode this is {C-c C-x or M} Left
"
nmap <buffer> <C-Left> <esc>:s/^\*/*&/<cr>
imap <buffer> <C-Left> <esc><C-Left>`^a

" mapping to demote (more *) a heading; in emacs org-mode this is {C-c C-x or M} Right
"
nmap <buffer> <C-Right> <esc>:s/^\*//<cr>
imap <buffer> <C-Right> <esc><C-Right>`^a

call PostHandlerHook()
