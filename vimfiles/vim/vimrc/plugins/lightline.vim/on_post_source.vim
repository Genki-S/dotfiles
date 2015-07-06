" FIXME: unknown bug. I need this to colorize statusline
try
	call lightline#highlight()
catch
endtry

augroup LightLine
	autocmd!
	autocmd WinEnter,BufWinEnter,FileType,ColorScheme,QuickFixCmdPost * call s:filtered_lightline_call('update')
	autocmd ColorScheme,SessionLoadPost * call s:filtered_lightline_call('highlight')
	autocmd CursorMoved,BufUnload * call s:filtered_lightline_call('update_once')
augroup END

function! s:filtered_lightline_call(funcname)
	if bufname('%') == '__CS__' || &ft == 'qf'
		return
	endif
	execute 'call lightline#' . a:funcname . '()'
endfunction
