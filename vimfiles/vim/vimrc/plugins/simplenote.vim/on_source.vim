let s:credential = glob('~/.simplenoterc.vim')
if filereadable(s:credential)
	execute 'source' s:credential
else
	echoerr 'Make '. s:credential .' and setup credentials.'
endif
