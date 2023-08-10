function! s:ContextualTagbar() abort
	if !tagbar#IsOpen()
		TagbarOpen
	else
		TagbarShowTag
	endif
	" for closing, I can use <C-w>o
endfunction

nnoremap <silent> <Leader>T <Cmd>call <SID>ContextualTagbar()<CR>
