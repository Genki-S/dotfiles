" only use snippets defined by myself
let g:neosnippet#disable_runtime_snippets = {
			\   '_' : 1,
			\ }

let g:neosnippet#snippets_directory = [g:nvim_config_dir . '/snippets']

function! g:Neosnippet_edit_with_example() abort
	let l:ft = &filetype
	vsplit
	NeoSnippetEdit
	let l:winnr = winnr()
	execute 'split' expand('$HOME/ghq/github.com/Shougo/neosnippet-snippets/neosnippets/' . l:ft . '.snip')
	wincmd p
endfunction
