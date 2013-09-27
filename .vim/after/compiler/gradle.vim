" Vim Compiler File
" Compiler: gradle
" 
" Taken from https://github.com/niklasl/vimheap/blob/master/compiler/gradle.vim
" Modified to support gradle wrapper.
" Modified to use demon mode.
"

if exists(":CompilerSet") != 2
	command -nargs=* CompilerSet setlocal <args>
endif

if filereadable("./gradlew")
	CompilerSet makeprg=./gradlew\ --daemon
elseif
	CompilerSet makeprg=gradle\ --daemon
endif

CompilerSet errorformat=
			\%-G:%.%\\+,
			\%E%f:\ %\\d%\\+:\ %m\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
			\%E%>%f:\ %\\d%\\+:\ %m,%C\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
			\%-G\\s%#,
			\%-GBUILD\ SUCCESSFUL#,
			\%-GTotal\ \time:\ %.%#
