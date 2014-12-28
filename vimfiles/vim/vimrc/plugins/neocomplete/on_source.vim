" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use neocomplete over other plugins
let g:neocomplete#force_overwrite_completefunc = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#text_mode_filetypes = {
	\ 'text': 1,
	\ 'tex': 1,
	\ 'markdown': 1,
	\ 'mmd': 1,
	\ 'gitcommit': 1,
\ }

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <expr> <C-y>  neocomplete#close_popup()
inoremap <expr> <C-e>  neocomplete#cancel_popup()

" Easily disable (the unimpaired way)
nnoremap [oC :<C-u>NeoCompleteEnable<CR>
nnoremap ]oC :<C-u>NeoCompleteDisable<CR>

" Enable omni completion.
autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
