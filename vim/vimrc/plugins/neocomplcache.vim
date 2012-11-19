let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_text_mode_filetypes = {
	\ 'text': 1,
	\ 'tex': 1,
	\ 'gitcommit': 1,
\ }

" Plugin key-mappings.
inoremap <unique> <expr><C-g> neocomplcache#undo_completion()
inoremap <unique> <expr><C-l> neocomplcache#complete_common_string()
inoremap <unique> <expr><C-y> neocomplcache#close_popup()
inoremap <unique> <expr><C-e> neocomplcache#cancel_popup()
imap <unique> <C-j> <Plug>(neocomplcache_snippets_expand)
smap <unique> <C-j> <Plug>(neocomplcache_snippets_expand)

inoremap <unique> <expr><C-y>  neocomplcache#close_popup()
inoremap <unique> <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
" scss pattern is identical as css pattern
let g:neocomplcache_omni_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'

autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Snippet
let g:neocomplcache_snippets_dir = '~/.vim/snippets'
