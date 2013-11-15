let g:syntastic_auto_loc_list = 2
let g:syntastic_mode_map = {
	\ 'mode': 'inactive',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': []
\}

augroup AutoSyntastic
	autocmd!
	autocmd BufWritePost * call s:syntastic_with_lightline()
augroup END

function! s:syntastic_with_lightline()
	SyntasticCheck
	call lightline#update()
endfunction
