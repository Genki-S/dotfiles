" Include snippets from https://github.com/honza/vim-snippets
let g:neosnippet#enable_snipmate_compatibility = 1
let g:snippets_dir = '~/.vim/bundles/vim-snippets/snippets'

let g:neosnippet#snippets_directory = '~/.vim/snippets'

imap <C-i> <Plug>(neosnippet_expand_or_jump)
smap <C-i> <Plug>(neosnippet_jump_or_expand)

" HACK: neosnippet takes all texts before cursor as Unite input on invocation.
"       last <C-u> in this mapping deletes it so that it's easier to search snippets.
"       this makes expansion wired sometimes, but it makes me remember snippet triggers, I hope...
imap <Leader><C-i> <Plug>(neosnippet_start_unite_snippet)<C-u>
