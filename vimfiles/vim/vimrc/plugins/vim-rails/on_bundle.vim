nnoremap <Leader>r :echoerr 'Not in Rails Mode'<CR>

" For rspec-console
nnoremap <silent> <SID>[rails]r :call <SID>vimux_rspec_console()<CR>

function! s:vimux_rspec_console()
	if !exists('g:VimuxRunnerPaneIndex')
		NeoBundleSource vimux
		call VimuxRunCommand('rails c test')
	endif
	call VimuxRunCommand('rspec ' . expand('%') . ':' . line('.'))
endfunction
