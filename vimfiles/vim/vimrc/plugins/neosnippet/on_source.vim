let g:neosnippet#snippets_directory = '~/.vim/snippets'
let g:neosnippet#enable_snipmate_compatibility = 1

imap <C-k> <Plug>(neosnippet_jump_or_expand)
smap <C-k> <Plug>(neosnippet_jump_or_expand)

" Source snippets from https://github.com/honza/vim-snippets/tree/master/snippets
let s:vim_snippets_dir = '~/.vim/bundles/vim-snippets/snippets'
function! s:source_vim_snippets(filetype)
	for snippet in split(glob(s:vim_snippets_dir . '/' . a:filetype . '*'))
		execute 'NeoSnippetSource' snippet
	endfor
endfunction
autocmd FileType * call s:source_vim_snippets(expand('<amatch>'))
