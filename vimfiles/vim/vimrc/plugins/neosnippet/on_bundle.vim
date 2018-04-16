" Include snippets from https://github.com/honza/vim-snippets
let g:neosnippet#enable_snipmate_compatibility = 1
let g:snippets_dir = '~/.vim/bundles/vim-snippets/snippets'

let g:neosnippet#snippets_directory = ['~/.vim/snippets']

" go snippets
let s:gosnippets_dir = '~/.vim/bundles/vim-go/gosnippets/snippets'
let g:neosnippet#snippets_directory = g:neosnippet#snippets_directory + [s:gosnippets_dir]
