" Vim Compiler File
" Compiler: gradle
" 
" Taken from https://github.com/niklasl/vimheap/blob/master/compiler/gradle.vim
"

if exists(":CompilerSet") != 2
	command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=gradle

CompilerSet errorformat=
			\%-G:%.%\\+,
			\%E%f:\ %\\d%\\+:\ %m\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
			\%E%>%f:\ %\\d%\\+:\ %m,%C\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
			\%-G\\s%#,
			\%-GBUILD\ SUCCESSFUL#,
			\%-GTotal\ \time:\ %.%#
