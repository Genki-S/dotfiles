if has('mksession')
	set viewdir=~/.tmp/vim/view
	set viewoptions=folds,options,cursor
endif

let g:skipview_files = [
\	'[EXAMPLE PLUGIN BUFFER]'
\]

function! MakeViewCheck()
	if has('quickfix') && &buftype =~ 'nofile'
		" Buffer is marked as not a file
		return 0
	endif
	if empty(glob(expand('%:p')))
		" File does not exist on disk
		return 0
	endif
	if index(g:skipview_files, expand('%')) >= 0
		" File is in skip list
		return 0
	endif
	return 1
endfunction

augroup vimrcAutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePost,BufLeave,WinLeave ?*
\		if MakeViewCheck()
\|			mkview
\|		endif
    autocmd BufWinEnter ?*
\		if MakeViewCheck()
\|			silent loadview
\|		endif
augroup end
