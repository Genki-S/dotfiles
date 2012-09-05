" --------------------------------------------------
" Unite.vim
" --------------------------------------------------
nnoremap [unite] <Nop>
nmap <Space> [unite]

nnoremap <silent> [unite]b :Unite -auto-preview -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]f :Unite -auto-preview -buffer-name=file file<CR>
nnoremap <silent> [unite]m :Unite -auto-preview -buffer-name=mru file_mru<CR>
nnoremap <silent> [unite]r :Unite -auto-preview -buffer-name=reccursive file_rec<CR>
nnoremap <silent> [unite]R :Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]c :Unite -buffer-name=command command<CR>
nnoremap <silent> [unite]l :Unite -buffer-name=line line<CR>
nnoremap <silent> [unite]B :Unite -buffer-name=lazy_bundles neobundle/lazy<CR>
nnoremap <silent> [unite]h :Unite -buffer-name=help help<CR>
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

" Plugin key-mappings.
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
imap <C-j> <Plug>(neocomplcache_snippets_expand)
smap <C-j> <Plug>(neocomplcache_snippets_expand)

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><silent> <CR> <SID>my_cr_function()
function! s:my_cr_function()
	return pumvisible() ? neocomplcache#close_popup() . "\<CR>" : "\<CR>"
endfunction

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

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

" --------------------------------------------------
" vim-fugitive
" --------------------------------------------------
nnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]
nnoremap [fugitive]<Space> :Git 
nnoremap [fugitive]s :Gstatus<CR>
nnoremap [fugitive]c :Gcommit<CR>
nnoremap [fugitive]C :Git commit --amend<CR>
nnoremap [fugitive]g :Ggrep 
nnoremap [fugitive]l :Glog 
nnoremap [fugitive]e :Gedit 
nnoremap [fugitive]v :Gvsplit 
nnoremap [fugitive]t :Gtabedit 
nnoremap [fugitive]re :Gread<CR>
nnoremap [fugitive]w :Gwrite<CR>
nnoremap [fugitive]d :Gdiff 
nnoremap [fugitive]m :Gmove 
nnoremap [fugitive]rm :Gremove<CR>
nnoremap [fugitive]b :Gblame<CR>

" --------------------------------------------------
" vim-ref
" --------------------------------------------------

" mappings
nnoremap [ref] <Nop>
nmap <Leader>, [ref]
nnoremap [ref]a :Ref webdict alc 
nnoremap [ref]l :Ref webdict longman 
nnoremap [ref]w :Ref webdict wikipedia 
nnoremap <silent> [ref]K :execute 'Ref webdict alc ' . expand('<cword>')<CR>

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
nnoremap <silent> [async]m :AsyncMake<CR>
nnoremap <silent> [async]s :AsyncShell 
nnoremap <silent> [async]g :AsyncGrep 
nnoremap <F9> :AsyncMake<CR>:echo "making..."<CR>
nnoremap <F8> :!./a.out<CR>

" --------------------------------------------------
" Quickhl
" --------------------------------------------------
nnoremap [quickhl] <Nop>
nmap <Leader>h [quickhl]
nmap [quickhl]t <Plug>(quickhl-toggle)
xmap [quickhl]t <Plug>(quickhl-toggle)
nmap [quickhl]r <Plug>(quickhl-reset)
xmap [quickhl]r <Plug>(quickhl-reset)
nnoremap <silent> [quickhl]l :QuickhlLock<CR>
nnoremap <silent> [quickhl]u :QuickhlUnLock<CR>
nnoremap <silent> [quickhl]s :QuickhlList<CR>
