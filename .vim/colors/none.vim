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
" code or odd colour patterns!  If you prefer a similar appearance in both
" cterm/gui from your colorscheme, especially one that is easy on the eyes,
" this colo might be for you ;-). Most of the syntax highlighting has been
" removed (see options), and anything that remains is kept for value. A
" terminal supporting 8 or more colours plus the underline and bold
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
" let g:none_usecolorwords      : makes some keywords stand out

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
hi Visual           ctermfg=grey    ctermbg=black 
" cursor colours
hi Cursor           guibg=black     guifg=white
" set cul -> underline the line the cursor is on
hi CursorLine       cterm=underline gui=underline

" the line between windows after :vsp
hi VertSplit        ctermbg=white   ctermfg=black 
hi VertSplit        guibg=#ffffff   guifg=#ce8639

" mode line, e.g. insert, visual mode
"hi ModeMsg         


" X. spell checker colours.
if v:version >= 7 && exists("+spell")
"   hi SpellBad     ctermfg=white   ctermbg=red cterm=underline
"   hi SpellCap     ctermfg=white   ctermbg=green
"   hi SpellLocal   ctermfg=white   ctermbg=green
"   hi SpellRare    ctermfg=white   ctermbg=green
endif

" the colours for the status line below, e.g. filename, etc
"hi StatusLine      ctermfg=white   ctermbg=black 
"hi StatusLine      guifg=#008080   guibg=#fff5ee
"hi StatusLineNC    guifg=gray      guibg=#008080
if &bg == "light"
    hi StatusLine       ctermfg=white   ctermbg=black 
    hi StatusLine       guibg=#ffffff   guifg=#ce8639
    hi StatusLineNC     ctermfg=black   ctermbg=white 
    hi StatusLineNC     guifg=#008080   guibg=#fff5ee
elseif &bg == "dark"
    hi StatusLine       ctermfg=white   ctermbg=black 
    hi StatusLine       guibg=#ffffff   guifg=#ce8639
    hi StatusLineNC     ctermfg=black   ctermbg=white 
    hi StatusLineNC     guifg=#008080   guibg=#fff5ee
endif

"hi StatusLine* Question Search

" The line numbers when 'numbers' is set
hi LineNr           ctermfg=yellow  cterm=NONE      guifg=brown
hi LineNr           guifg=brown

" closed folds
hi Folded           ctermbg=NONE    ctermfg=cyan 
hi Folded           guifg=blue      guibg=NONE      gui=bold
" fold column indicator
hi FoldColumn       ctermbg=NONE    ctermfg=cyan 
hi FoldColumn       guifg=cyan      guibg=NONE      gui=bold

" Tab bar colours
"
" inactive tabs
hi TabLine          ctermbg=NONE    ctermfg=white
hi TabLine          guibg=NONE      guifg=black     guibg=#00ced1
" active tab
hi TabLineSel       cterm=bold
hi TabLineSel       gui=bold        guibg=#ce8639   guifg=black
" blank space in the tab bar
hi TabLineFill      cterm=underline
hi TabLineFill      gui=underline   guibg=#00ced1


" search highlights when 'hls' is set
"hi Search          

" omni-completion pop up colours
hi Pmenu            ctermbg=black       ctermfg=red 
hi Pmenu            guibg=black         guifg=red
hi PmenuSel         ctermbg=lightgreen  cterm=underline  
hi PmenuSel         guibg=darkgreen     gui=underline

" Directory browsers dir colours
hi Directory        ctermfg=magenta     cterm=NONE  guifg=magenta 

" GUI scrollbar colour
"hi Scrollbar       x
" GUI Menu/tool bar colour
"hi Menu            x
" GUI tool tips
"hi Tooltip         x

" hilight for control charactors
hi SpecialKey       ctermfg=yellow  cterm=bold
" hilight for sm/mps
hi MatchParen       ctermfg=NONE    ctermbg=NONE    cterm=bold 
hi MatchParen       guifg=NONE      guibg=NONE      gui=bold

"syntax highlighting stuff

if !exists("g:none_usecolorcomments")
    hi Comment      ctermfg=NONE    ctermbg=NONE 
    hi Comment      guifg=NONE      guibg=NONE      gui=NONE
else
    hi Comment      ctermfg=green   ctermbg=NONE 
    hi Comment      guifg=seagreen  guibg=NONE      gui=bold
endif
hi Constant         ctermfg=NONE    ctermbg=NONE    cterm=NONE 
hi Constant         guifg=NONE      guibg=NONE      gui=NONE
" various constant symbols
    if !exists("g:none_usecolorstrings")
        hi Character    ctermfg=NONE    ctermbg=NONE    cterm=NONE 
        hi Character    guifg=NONE      guibg=NONE      gui=NONE
        hi String       ctermfg=NONE    ctermbg=NONE    cterm=NONE 
        hi String       guifg=NONE      guibg=NONE      gui=NONE
    else
        hi Character    ctermfg=brown   ctermbg=NONE    cterm=NONE 
        hi Character    guifg=brown     guibg=NONE      gui=NONE
        hi String       ctermfg=brown   ctermbg=NONE    cterm=NONE 
        hi String       guifg=brown     guibg=NONE      gui=NONE
    endif
    hi Number           ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Number           guifg=NONE      guibg=NONE      gui=NONE
    hi Boolean          ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Boolean          guifg=NONE      guibg=NONE      gui=NONE
    hi Float            ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Float            guifg=NONE      guibg=NONE      gui=NONE
    hi Identifier       ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Identifier       guifg=NONE      guibg=NONE      gui=NONE
    hi Function         ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Function         guifg=NONE      guibg=NONE      gui=NONE
    hi Statement        ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Statement        guifg=NONE      guibg=NONE      gui=NONE
if !exists("g:none_usecolorwords")
    " if, then, else, endif, switch, etc
    hi Conditional      ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Conditional      guifg=NONE      guibg=NONE      gui=bold
    " for, do, while, etc
    hi Repeat           ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Repeat           guifg=NONE      guibg=NONE      gui=NONE
    " try, catch, throw, etc
    hi Exception        ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Exception        guifg=NONE      guibg=NONE      gui=NONE
else
    hi Conditional      ctermfg=yellow  ctermbg=NONE    cterm=NONE 
    hi Conditional      guifg=darkred   guibg=NONE      gui=bold
    hi Repeat           ctermfg=yellow  ctermbg=NONE    cterm=NONE 
    hi Repeat           guifg=darkred   guibg=NONE      gui=bold
    hi Exception        ctermfg=yellow  ctermbg=NONE    cterm=NONE 
    hi Exception        guifg=darkred   guibg=NONE      gui=bold
endif
" case, default, label:, etc
    hi Label        ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Label        guifg=NONE      guibg=NONE      gui=NONE
    " sizeof, +, *, etc
    hi Operator     ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Operator     guifg=NONE      guibg=NONE      gui=NONE
    " any other keyword
    hi Keyword      ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Keyword      guifg=NONE      guibg=NONE      gui=NONE
hi PreProc          ctermfg=NONE    ctermbg=NONE    cterm=NONE 
hi PreProc          guifg=NONE      guibg=NONE      gui=NONE
    " #include, etc
    if !exists("g:none_usecolorimports")
        hi Include                  ctermfg=NONE    ctermbg=NONE 
        hi Include                  guifg=NONE      guibg=NONE      gui=NONE
    else
        hi Include                  ctermfg=blue    ctermbg=NONE 
        hi Include                  guifg=blue      guibg=NONE      gui=bold
        " A few language specific things
        hi cIncluded                ctermfg=brown   guifg=brown
        hi pythonPreCondit          ctermfg=blue    guifg=blue      gui=bold
        hi perlStatementInclude     ctermfg=blue    guifg=blue      gui=bold
    endif
    " #define, etc
    hi Define       ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Define       guifg=NONE      guibg=NONE      gui=NONE
    hi Macro        ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Macro        guifg=NONE      guibg=NONE      gui=NONE
    " #if, #else, #endif, etc
    hi PreCondit    ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi PreCondit    guifg=NONE      guibg=NONE      gui=NONE
if !exists("g:none_usestyles")
    hi Type         ctermfg=NONE    ctermbg=NONE 
    hi Type         guifg=NONE      guibg=NONE      gui=NONE
        " static, register, volatile, etc
        hi StorageClass             ctermfg=NONE    ctermbg=NONE 
        hi StorageClass             guifg=NONE      guibg=NONE      gui=NONE
else
    hi Type         ctermfg=NONE    ctermbg=NONE    cterm=underline
    hi Type         guifg=NONE      guibg=NONE      gui=underline
        " static, register, volatile, etc
        hi StorageClass             ctermfg=NONE    ctermbg=NONE    cterm=bold
        hi StorageClass             guifg=NONE      guibg=NONE      gui=bold
endif
        " struct, union, enum, etc
        hi Structure                ctermfg=NONE    ctermbg=NONE 
        hi Structure                guifg=NONE      guibg=NONE      gui=NONE
        hi Typedef                  ctermfg=NONE    ctermbg=NONE 
        hi Typedef                  guifg=NONE      guibg=NONE      gui=NONE
hi Special          ctermfg=NONE    ctermbg=NONE    cterm=NONE 
hi Special          guifg=NONE      guibg=NONE      gui=NONE
    hi SpecialChar  ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi SpecialChar  guifg=NONE      guibg=NONE      gui=NONE
    " things you can CTRL-} on
    hi Tag          ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Tag          guifg=NONE      guibg=NONE      gui=NONE
    hi Delimiter    ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Delimiter    guifg=NONE      guibg=NONE      gui=NONE
    hi Debug        ctermfg=NONE    ctermbg=NONE    cterm=NONE 
    hi Debug        guifg=NONE      guibg=NONE      gui=NONE
"hi Underlined       ctermfg=NONE    ctermbg=NONE    cterm=NONE 
"hi Underlined       guifg=NONE      guibg=NONE      gui=NONE
"hi Ignore           ctermfg=NONE    ctermbg=NONE    cterm=NONE 
"hi Ignore           guifg=NONE      guibg=NONE      gui=NONE
hi Error            ctermfg=red     ctermbg=NONE 
hi Error            guifg=red       guibg=NONE      gui=bold
hi Todo             ctermfg=NONE    ctermbg=NONE    cterm=bold 
hi Todo             guifg=NONE      guibg=NONE      gui=bold


" Some colours for Dr Chips manpageview plugin
hi manTitle             ctermfg=magenta 
hi manSectionTitle      ctermfg=magenta 
hi manReference         ctermfg=yellow
