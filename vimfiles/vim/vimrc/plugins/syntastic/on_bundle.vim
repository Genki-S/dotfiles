nnoremap <Leader><CR> :<C-u>call Syntastic_with_lightline()<CR>

function! Syntastic_with_lightline()
	SyntasticCheck
	call lightline#update()
endfunction
