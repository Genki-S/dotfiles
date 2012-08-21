" --------------------------------------------------
" Unite.vim
" --------------------------------------------------
nnoremap [unite] <Nop>
nmap <Space> [unite]

nnoremap <silent> [unite]b :Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]f :Unite -buffer-name=file file<CR>
nnoremap <silent> [unite]m :Unite -buffer-name=mru file_mru<CR>
nnoremap <silent> [unite]r :Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]c :Unite -buffer-name=command command<CR>
nnoremap <silent> [unite]l :Unite -buffer-name=line line<CR>
nnoremap <silent> [unite]<Space> :Unite -buffer-name=source source<CR>

" --------------------------------------------------
" unite-outline
" --------------------------------------------------
nnoremap <silent> [unite]o :Unite -buffer-name=outline outline<CR>

" --------------------------------------------------
" NeoComplCache
" --------------------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_disable_auto_complete = 1

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
let g:neocomplcache_snippets_dir = '~/.vim/snippets'

" Plugin key-mappings.
imap <C-j> <Plug>(neocomplcache_snippets_expand)
smap <C-j> <Plug>(neocomplcache_snippets_expand)

" --------------------------------------------------
" vim-fugitive
" --------------------------------------------------
nmap <Leader>g<Space> :Git 
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gg :Ggrep 
nmap <Leader>gl :Glog 
nmap <Leader>ge :Gedit 
nmap <Leader>gv :Gvsplit 
nmap <Leader>gt :Gtabedit 
nmap <Leader>gre :Gread<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gd :Gdiff 
nmap <Leader>gm :Gmove 
nmap <Leader>grm :Gremove<CR>
nmap <Leader>gb :Gblame<CR>

" --------------------------------------------------
" vim-ref
" --------------------------------------------------

" mappings
nnoremap [ref] <Nop>
nmap , [ref]
nmap [ref]a :Ref webdict alc 
nmap [ref]l :Ref webdict longman 
nmap [ref]w :Ref webdict wikipedia 
nmap <silent> [ref]K :execute 'Ref webdict alc ' . expand('<cword>')<CR>

" sources
let g:ref_source_webdict_sites = {
\	'alc': {
\		'url': 'http://eow.alc.co.jp/search?q=%s',
\		'keyword_encoding': 'utf-8',
\		'cache': 1,
\	},
\	'longman': {
\		'url': 'http://www.ldoceonline.com/dictionary/%s',
\		'keyword_encoding': 'utf-8',
\		'cache': 1,
\	},
\	'wikipedia': {
\		'url': 'http://en.wikipedia.org/wiki/%s',
\		'keyword_encoding': 'utf-8',
\		'cache': 1,
\	}
\}

" output modulations
function! g:ref_source_webdict_sites.alc.filter(output)
	return join(split(a:output, "\n")[35 :], "\n")
endfunction

" --------------------------------------------------
" open-browser
" --------------------------------------------------
nmap <Leader>K <Plug>(openbrowser-smart-search)
vmap <Leader>K <Plug>(openbrowser-smart-search)

" --------------------------------------------------
" AsyncCommand
" --------------------------------------------------
nnoremap [async] <Nop>
nmap <Leader>a [async]
nmap <silent> [async]m :AsyncMake<CR>
nmap <silent> [async]s :AsyncShell 
nmap <silent> [async]g :AsyncGrep 
nmap <F9> :AsyncMake<CR>:echo "making..."<CR>
nmap <F8> :!./a.out<CR>
