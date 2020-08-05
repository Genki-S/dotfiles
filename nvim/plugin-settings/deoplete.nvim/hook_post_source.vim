augroup vimrc_deoplete.nvim
	autocmd!
	autocmd CompleteDone * silent! pclose!
augroup END
