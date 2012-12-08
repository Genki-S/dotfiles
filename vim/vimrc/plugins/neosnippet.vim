" Snippet
let g:neosnippet#snippets_directory = '~/.vim/snippets'
imap <unique> <C-j> <Plug>(neosnippet_expand_or_jump)

augroup MAPMODE-S
	autocmd!
	autocmd VimEnter * smapclear
	autocmd VimEnter * smap <unique> <C-j> <Esc>i<Plug>(neosnippet_expand_or_jump)
augroup END
