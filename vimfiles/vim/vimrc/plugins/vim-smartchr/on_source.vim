augroup vimrc_vim-smartchr
	autocmd!
	autocmd FileType go inoremap <buffer> <expr> ; smartchr#loop(' := ', ';')
augroup END
