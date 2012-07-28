if filereadable('Makefile')
	setlocal makeprg=make
else
	setlocal makeprg=make\ -f\ ~/programming/tools/makefiles/cpp.mk
endif
