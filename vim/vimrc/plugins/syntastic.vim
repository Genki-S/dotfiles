let g:syntastic_mode_map = {
	\ 'mode': 'passive',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': []
\}

nnoremap <unique> <silent> <Leader><CR> :<C-u>SyntasticCheck<CR>
