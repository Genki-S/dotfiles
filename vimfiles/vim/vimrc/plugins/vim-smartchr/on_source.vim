augroup vimrc_vim-smartchr
	autocmd!
	autocmd FileType go inoremap <expr> ; smartchr#loop(' := ', ';')
augroup END
