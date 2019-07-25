function! s:alternate() abort
	try
		A
	catch /No alternate file/
		execute "normal! \<C-^>"
	endtry
endfunction

nnoremap <silent> <C-^> <Cmd>call <SID>alternate()<CR>
