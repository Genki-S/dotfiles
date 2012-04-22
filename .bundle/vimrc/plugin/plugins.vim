" NeoComplCache Start
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Use camel case completion.
	let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	let g:neocomplcache_enable_underbar_completion = 1
	" Plugin key-mappings.
	inoremap <expr><C-g> neocomplcache#undo_completion()
	inoremap <expr><C-l> neocomplcache#complete_common_string()
	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	" Snippet
	let g:neocomplcache_snippets_dir = '~/.bundle/neocomplcache-snippets-complete/snippets'
	" Plugin key-mappings.
	imap <C-k> <Plug>(neocomplcache_snippets_expand)
	smap <C-k> <Plug>(neocomplcache_snippets_expand)
" NeoComplCache End

" SingleCompile Start
	nmap <F9> :SCCompileRun<CR>
" SingleCompile End

" Vim-LaTeX Start
	filetype plugin on
	set shellslash
	set grepprg=grep\-nH\$*
	filetype indent on
	let g:Tex_CompileRule_dvi='platex $*'
	let g:Tex_ViewRule_dvi='xdvi'
" Vim-LaTeX End
