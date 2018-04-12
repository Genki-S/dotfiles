imap <C-i> <Plug>(neosnippet_jump)
smap <C-i> <Plug>(neosnippet_jump)

imap <C-k> <Plug>(neosnippet_expand)
smap <C-k> <Plug>(neosnippet_expand)

" HACK: neosnippet takes all texts before cursor as Unite input on invocation.
"       last <C-u> in this mapping deletes it so that it's easier to search snippets.
"       this makes expansion wired sometimes, but it makes me remember snippet triggers, I hope...
imap <Leader><C-k> <Plug>(neosnippet_start_unite_snippet)<C-u>
