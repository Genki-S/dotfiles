let g:neosnippet#snippets_directory = '~/.vim/snippets'
imap <unique> <C-k> <Plug>(neosnippet_expand_or_jump)

augroup MAPMODE-S
	autocmd!
	autocmd VimEnter * smapclear
	autocmd VimEnter * smap <unique> <C-k> <Esc>i<Plug>(neosnippet_expand_or_jump)
augroup END
