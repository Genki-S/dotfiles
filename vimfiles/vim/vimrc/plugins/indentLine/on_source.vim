let g:indentLine_fileTypeExclude = ['text', 'help']
augroup vimrc_indentLine
	autocmd!
	autocmd BufWinEnter,BufRead,BufNewFile,ColorScheme * setlocal conceallevel=1
augroup END
