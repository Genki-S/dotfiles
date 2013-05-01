" mappings
nnoremap <unique> <SID>[ref] <Nop>
nmap <unique> <Leader>, <SID>[ref]
nnoremap <unique> <SID>[ref]a :Ref webdict alc 
nnoremap <unique> <SID>[ref]c :Ref webdict collins 
nnoremap <unique> <SID>[ref]w :Ref webdict wikipedia 
nnoremap <expr> <unique> <SID>[ref]k ":Ref " . ref#detect() . " "
nnoremap <unique> <silent> <SID>[ref]K :execute 'Ref webdict alc ' . expand('<cword>')<CR>

" Sources
let g:ref_detect_filetype = {
\	'c': 'man',
\	'cpp': 'cppref',
\	'ruby': 'ri',
\}

" Aditional web sources
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