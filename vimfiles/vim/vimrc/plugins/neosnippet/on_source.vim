" Include snippets from https://github.com/honza/vim-snippets
let s:vim_snippets_dir = '~/.vim/bundles/vim-snippets/snippets'
let g:neosnippet#snippets_directory = [s:vim_snippets_dir, '~/.vim/snippets']

let g:neosnippet#enable_snipmate_compatibility = 1

imap <C-k> <Plug>(neosnippet_jump_or_expand)
smap <C-k> <Plug>(neosnippet_jump_or_expand)
