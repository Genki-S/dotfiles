let g:syntastic_auto_loc_list = 2
let g:syntastic_mode_map = {
	\ 'mode': 'inactive',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': []
\}

nnoremap <Leader><CR> :<C-u>call Syntastic_with_lightline()<CR>

function! Syntastic_with_lightline()
	SyntasticCheck
	call lightline#update()
endfunction
