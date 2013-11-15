let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
	let g:lightline.fname = a:fname
	return lightline#statusline(0)
endfunction

let g:tagbar_type_scss = {
	\ 'ctagstype' : 'Scss',
	\ 'kinds' : [
		\ 'c:classes',
		\ 'i:ids',
		\ 's:selectors',
		\ 'm:mixins',
		\ 'v:variables',
	\ ]
\ }

let g:tagbar_type_scala = {
	\ 'ctagstype' : 'Scala',
	\ 'kinds' : [
		\ 'p:packages:1',
		\ 'V:values',
		\ 'v:variables',
		\ 'T:types',
		\ 't:traits',
		\ 'o:objects',
		\ 'a:aclasses',
		\ 'c:classes',
		\ 'r:cclasses',
		\ 'm:methods'
	\ ]
\ }
