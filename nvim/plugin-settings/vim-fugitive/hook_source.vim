augroup vimrc_vim-fugitive
	autocmd!
	autocmd FileType fugitive nnoremap <buffer><silent> ? :h fugitive-staging-maps<CR>
	" keep the old behavior of closing blame window with q: https://github.com/tpope/vim-fugitive/issues/1221
	autocmd FileType fugitiveblame nmap <buffer> q gq
augroup END
