" Include snippets from https://github.com/honza/vim-snippets
let g:neosnippet#enable_snipmate_compatibility = 1
let g:snippets_dir = '~/.vim/bundles/vim-snippets/snippets'

let g:neosnippet#snippets_directory = '~/.vim/snippets'

imap <C-k> <Plug>(neosnippet_jump_or_expand)
smap <C-k> <Plug>(neosnippet_jump_or_expand)
imap <Leader><C-k> <Plug>(neosnippet_start_unite_snippet)
