let g:lightline = {}

let g:lightline.active = {
			\ 'left': [ [ 'quickfix', 'mode', 'paste' ],
			\           [ 'readonly', 'filename', 'modified' ] ],
			\ 'right': [ [ 'lineinfo' ],
			\            [ 'percent' ],
			\            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

let g:lightline.component_expand = {
			\ 'quickfix': 'MyLightlineQuickfix' }

let g:lightline.component_type = {
			\ 'quickfix': 'error' }

function! MyLightlineQuickfix()
	let qflist = getqflist()
	call filter(qflist, 'v:val.valid != 0')
	if len(qflist) == 0
		return ''
	endif
	return "[ QF: " . len(qflist) . " item(s) ]"
endfunction
