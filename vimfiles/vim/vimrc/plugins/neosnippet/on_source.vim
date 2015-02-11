" Include snippets from https://github.com/honza/vim-snippets
let g:neosnippet#enable_snipmate_compatibility = 1
let g:snippets_dir = '~/.vim/bundles/vim-snippets/snippets'

let g:neosnippet#snippets_directory = '~/.vim/snippets'

imap <C-i> <Plug>(neosnippet_expand_or_jump)
smap <C-i> <Plug>(neosnippet_expand_or_jump)
imap <Leader><C-i> <Plug>(neosnippet_start_unite_snippet)
