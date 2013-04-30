set hidden
set autoread
augroup vimrc-checktime
	autocmd!
	autocmd WinEnter * checktime
augroup END
