if filereadable('Makefile')
	setlocal makeprg=make
else
	setlocal makeprg=g++\ -g\ %
endif
