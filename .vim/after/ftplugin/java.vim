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
	compiler gradle
elseif filereadable("./pom.xml")
	compiler maven3
elseif filereadable("./build.xml")
	compiler ant
endif

call PostHandlerHook()
