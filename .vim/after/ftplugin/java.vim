call PreHandlerHook()

set formatoptions+=tcroqn
setl tabstop=4 shiftwidth=4 expandtab

if has("folding")
	setl foldmethod=indent
endif

" Ignore class files in filename completion
set wildignore+=*.class

" Setup :make to use the common build systems.
if filereadable("./build.gradle")
	set makeprg=gradle
elseif filereadable("./pom.xml")
	set makeprg=mvn
elseif filereadable("./build.xml")
	set makeprg=ant
endif

call PostHandlerHook()
