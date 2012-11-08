" mappings
nnoremap <SID>[ref] <Nop>
nmap <Leader>, <SID>[ref]
nnoremap <SID>[ref]a :Ref webdict alc 
nnoremap <SID>[ref]c :Ref webdict collins 
nnoremap <SID>[ref]w :Ref webdict wikipedia 
nnoremap <silent> <SID>[ref]K :execute 'Ref webdict alc ' . expand('<cword>')<CR>

" sources
let g:ref_source_webdict_sites = {
\	'alc': {
\		'url': 'http://eow.alc.co.jp/search?q=%s',
\		'keyword_encoding': 'utf-8',
\		'cache': 1,
\	},
\	'collins': {
\		'url': 'http://www.collinsdictionary.com/dictionary/english/%s',
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
function! g:ref_source_webdict_sites.collins.filter(output)
	return join(split(a:output, "\n")[60 :], "\n")
endfunction
