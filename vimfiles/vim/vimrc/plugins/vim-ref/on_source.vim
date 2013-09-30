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
