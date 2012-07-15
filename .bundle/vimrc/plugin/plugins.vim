" Unite.vim Start
	nnoremap [unite] <Nop>
	nmap <Space> [unite]

	nnoremap <silent> [unite]c :UniteWithCurrentDir -buffer-name=current_dir buffer file file_mru<CR>
	nnoremap <silent> [unite]b :UniteWithBufferDir -buffer-name=buffer_dir buffer file file_mru<CR>
	nnoremap <silent> [unite]f :Unite -buffer-name=file file<CR>
	nnoremap <silent> [unite]m :Unite -buffer-name=mru file_mru<CR>
	nnoremap <silent> [unite]r :Unite -buffer-name=register register<CR>
	nnoremap <silent> [unite]<Space> :Unite -buffer-name=source source<CR>
" Unite.vim End

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

" vim-fugitive Start
	nmap <Leader>g<Space> :Git! 
	nmap <Leader>gs :Gstatus<CR>
	nmap <Leader>gc :Gcommit<CR>
	nmap <Leader>gg :Ggrep 
	nmap <Leader>gl :Git! log<CR>
	nmap <Leader>ge :Gedit 
	nmap <Leader>gv :Gvsplit 
	nmap <Leader>gt :Gtabedit 
	nmap <Leader>gre :Gread<CR>
	nmap <Leader>gw :Gwrite<CR>
	nmap <Leader>gd :Gdiff 
	nmap <Leader>gm :Gmove 
	nmap <Leader>grm :Gremove<CR>
	nmap <Leader>gb :Gblame<CR>
" vim-fugitive End
