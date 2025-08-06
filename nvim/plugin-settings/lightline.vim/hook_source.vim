let g:lightline = {}

let g:lightline.active = {
			\ 'left': [ [ 'quickfix', 'loclist', 'windsurf', 'mode', 'paste' ],
			\           [ 'readonly', 'filename', 'modified' ] ],
			\ 'right': [ [ 'lineinfo' ],
			\            [ 'percent' ],
			\            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

let g:lightline.component_expand = {
			\ 'quickfix': 'MyLightlineQuickfix',
			\ 'loclist': 'MyLightlineLoclist',
			\ 'windsurf': 'MyWindsurfStatus' }

let g:lightline.component_type = {
			\ 'quickfix': 'error',
			\ 'loclist': 'warning' }

function! MyLightlineQuickfix()
	let qflist = getqflist()
	call filter(qflist, 'v:val.valid != 0')
	if len(qflist) == 0
		return ''
	endif
	return "[ QF: " . len(qflist) . " item(s) ]"
endfunction

function! MyLightlineLoclist()
	let loclist = getloclist(0)
	call filter(loclist, 'v:val.valid != 0')
	if len(loclist) == 0
		return ''
	endif
	return "[ LOC: " . len(loclist) . " item(s) ]"
endfunction

function! MyWindsurfStatus()
	return "AI:" . codeium#GetStatusString()
endfunction
