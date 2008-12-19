" vim: set ts=4 sw=4 et ai :
"
" Name: none.vim: a conservative colorscheme for Vim/gVim 
" Author: Terry M. Poulin <BigBoss1964@gmail.com 
" Date: 2008-12-18 
" Version: 2.4
"
"
" Notes:
"
" This colour scheme is designed for those who do not like Christmas tree like
" code or odd colour patterns!  If you prefer a similar vim/gvim appearance
" from your colorscheme, especially one that is easy on the eyes, this colo
" might be for you ;-). Most of the syntax highlighting has been removed (see
" options), and anything that remains is kept for value. Note well, that
" despite it's immense value that the CSApprox plugin will likely make this
" look horrible in a console in some setups (urxvt+screen on my system). A
" terminal supporting 8 or more colours plus and the underline and bold
" attributes at the same time  is recommended; but generally speaking is
" should not be required.
" 
" Options:  
"
" If any of these variables are found, they will acted upon; all are off by
" default. Their main purpose is to enable a minimalist form of syntax
" highlighting where desired.
"
" let g:none_usestyles          : makes some things bold/italic/underline
" let g:none_usecolorcomments   : use coloured comments 
" let g:none_usecolorimports    : makes some #include/import use colour
" let g:none_usecolorstrings    : makes "strings" use colours.
"

hi clear
"set background&
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "none"

" normal text
"hi Normal          
" ~, @ at the end of the window, characters from showbreak, etc
hi NonText          ctermfg=blue 
hi NoneText         guifg=blue 
" visual mode
hi Visual           ctermfg=grey ctermbg=black 
" cursor colours
hi Cursor           guibg=black guifg=white
" set cul -> underline the line the cursor is on
hi CursorLine       cterm=underline gui=underline

" the line between windows after :vsp
hi VertSplit        ctermbg=white ctermfg=black 
hi VertSplit        guibg=#ffffff guifg=#ce8639

" mode line, e.g. insert, visual mode
"hi ModeMsg         


" X. spell checker colours.
if v:version >= 7 && exists("+spell")
"   hi SpellBad     ctermfg=white ctermbg=red cterm=underline
"   hi SpellCap     ctermfg=white ctermbg=green
"   hi SpellLocal   ctermfg=white ctermbg=green
"   hi SpellRare    ctermfg=white ctermbg=green
endif

" the colours for the status line below, e.g. filename, etc
"hi StatusLine      ctermfg=white ctermbg=black guifg=#008080 guibg=#fff5ee
"hi StatusLineNC    guifg=gray guibg=#008080
if &bg == "light"
    hi StatusLine       ctermfg=white ctermbg=black 
    hi StatusLine       guibg=#ffffff guifg=#ce8639
    hi StatusLineNC     ctermfg=black ctermbg=white 
    hi StatusLineNC     guifg=#008080 guibg=#fff5ee
elseif &bg == "dark"
    hi StatusLine       ctermfg=white ctermbg=black 
    hi StatusLine       guibg=#ffffff guifg=#ce8639
    hi StatusLineNC     ctermfg=black ctermbg=white 
    hi StatusLineNC     guifg=#008080 guibg=#fff5ee
endif

"hi StatusLine* Question Search

" The line numbers when 'numbers' is set
hi LineNr           ctermfg=yellow cterm=none guifg=brown
hi LineNr           guifg=brown

" closed folds
hi Folded           ctermbg=none ctermfg=cyan 
hi Folded           guifg=blue guibg=white gui=bold
" fold column indicator
hi FoldColumn       ctermbg=none ctermfg=cyan 
hi FoldColumn       guifg=cyan guibg=white gui=bold

" Tab bar colours
"
" inactive tabs
hi TabLine          ctermbg=none ctermfg=white
" active tab
hi TabLineSel       cterm=bold
" blank space in the tab bar
hi TabLineFill      cterm=underline

" search highlights when 'hls' is set
"hi Search          

" omni-completion pop up colours
hi Pmenu            ctermbg=black ctermfg=red 
hi Pmenu            guibg=black guifg=red
hi PmenuSel         ctermbg=lightgreen cterm=underline  
hi PmenuSel         guibg=darkgreen gui=underline

" Directory browsers dir colours
hi Directory        ctermfg=magenta cterm=none guifg=magenta 

" GUI scrollbar colour
"hi Scrollbar       x
" GUI Menu/tool bar colour
"hi Menu            x
" GUI tool tips
"hi Tooltip         x

hi SpecialKey       ctermfg=yellow cterm=bold
hi MatchParen       ctermfg=none ctermbg=none cterm=bold 
hi MatchParen       guifg=black guibg=white gui=bold


"syntax highlighting stuff

if !exists("g:none_usecolorcomments")
    hi Comment      ctermfg=none ctermbg=none 
    hi Comment      guifg=black guibg=white gui=none
else
    hi Comment      ctermfg=green  ctermbg=none 
    hi Comment      guifg=seagreen guibg=white gui=bold
endif
hi Constant     ctermfg=none ctermbg=none cterm=none guifg=black guibg=white gui=none
" various constant symbols
    if !exists("g:none_usecolorstrings")
        hi Character    ctermfg=none ctermbg=none cterm=none 
        hi Character    guifg=black guibg=white gui=none
        hi String       ctermfg=none ctermbg=none cterm=none 
        hi String       guifg=black guibg=white gui=none
    else
        hi Character    ctermfg=brown ctermbg=none cterm=none 
        hi Character    guifg=brown guibg=white gui=none
        hi String       ctermfg=brown ctermbg=none cterm=none 
        hi String       guifg=brown guibg=white gui=none
    endif
    hi Number       ctermfg=none ctermbg=none cterm=none 
    hi Number       guifg=black guibg=white gui=none
    hi Boolean      ctermfg=none ctermbg=none cterm=none 
    hi Boolean      guifg=black guibg=white gui=none
    hi Float        ctermfg=none ctermbg=none cterm=none 
    hi Float        guifg=black guibg=white gui=none
hi Identifier       ctermfg=none ctermbg=none cterm=none 
hi Identifier       guifg=black guibg=white gui=none
hi Function         ctermfg=none ctermbg=none cterm=none 
hi Function         guifg=black guibg=white gui=none
hi Statement        ctermfg=none ctermbg=none cterm=none 
hi Statement        guifg=black guibg=white gui=none
    " if, then, else, endif, switch, etc
    hi Conditional  ctermfg=none ctermbg=none cterm=none 
    hi Conditional  guifg=black guibg=white gui=none
    " for, do, while, etc
    hi Repeat       ctermfg=none ctermbg=none cterm=none 
    hi Repeat       guifg=black guibg=white gui=none
    " case, default, etc
    hi Label        ctermfg=none ctermbg=none cterm=none 
    hi Label        guifg=black guibg=white gui=none
    " sizeof, +, *, etc
    hi Operator     ctermfg=none ctermbg=none cterm=none 
    hi Operator     guifg=black guibg=white gui=none
    " any other keyword
    hi Keyword      ctermfg=none ctermbg=none cterm=none 
    hi Keyword      guifg=black guibg=white gui=none
    " try, catch, throw, etc
    hi Exception    ctermfg=none ctermbg=none cterm=none 
    hi Exception    guifg=black guibg=white gui=none
hi PreProc          ctermfg=none ctermbg=none cterm=none 
hi PreProc          guifg=black guibg=white gui=none
    " #include, etc
    if !exists("g:none_usecolorimports")
        hi Include                  ctermfg=none ctermbg=none 
        hi Include                  guifg=black guibg=white gui=none
    else
        hi Include                  ctermfg=blue ctermbg=none 
        hi Include                  guifg=blue guibg=white gui=bold
        " A few language specific things
        hi cIncluded                ctermfg=brown guifg=brown
        hi pythonPreCondit          ctermfg=blue guifg=blue gui=bold
        hi perlStatementInclude     ctermfg=blue guifg=blue gui=bold
    endif
    " #define, etc
    hi Define       ctermfg=none ctermbg=none cterm=none 
    hi Define       guifg=black guibg=white gui=none
    hi Macro        ctermfg=none ctermbg=none cterm=none 
    hi Macro        guifg=black guibg=white gui=none
    " #if, #else, #endif, etc
    hi PreCondit    ctermfg=none ctermbg=none cterm=none 
    hi PreCondit    guifg=black guibg=white gui=none
if !exists("g:none_usestyles")
    hi Type     ctermfg=none ctermbg=none 
    hi Type     guifg=black guibg=white gui=none
        " static, register, volatile, etc
        hi StorageClass     ctermfg=none ctermbg=none 
        hi StorageClass     guifg=black guibg=white gui=none
else
    hi Type     ctermfg=none ctermbg=none cterm=underline
    hi Type     guifg=black guibg=white gui=underline
        " static, register, volatile, etc
        hi StorageClass     ctermfg=none ctermbg=none cterm=bold
        hi StorageClass     guifg=black guibg=white gui=bold
endif
        " struct, union, enum, etc
        hi Structure        ctermfg=none ctermbg=none 
        hi Structure        guifg=black guibg=white gui=none
        hi Typedef          ctermfg=none ctermbg=none 
        hi Typedef          guifg=black guibg=white gui=none
hi Special          ctermfg=none ctermbg=none cterm=none 
hi Special          guifg=black guibg=white gui=none
    hi SpecialChar  ctermfg=none ctermbg=none cterm=none 
    hi SpecialChar  guifg=black guibg=white gui=none
    " things you can CTRL-} on
    hi Tag          ctermfg=none ctermbg=none cterm=none 
    hi Tag          guifg=black guibg=white gui=none
    hi Delimiter    ctermfg=none ctermbg=none cterm=none 
    hi Delimiter    guifg=black guibg=white gui=none
    hi Debug        ctermfg=none ctermbg=none cterm=none 
    hi Debug        guifg=black guibg=white gui=none
"hi Underlined      ctermfg=none ctermbg=none cterm=none 
"hi Underlined      guifg=black guibg=white gui=none
"hi Ignore          ctermfg=none ctermbg=none cterm=none 
"hi Ignore          guifg=black guibg=white gui=none
hi Error            ctermfg=red ctermbg=none 
hi Error            guifg=red guibg=white gui=bold
hi Todo             ctermfg=none ctermbg=none cterm=bold 
hi Todo             guifg=black guibg=white gui=bold


