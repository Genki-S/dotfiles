let g:syntastic_auto_loc_list = 1
let g:syntastic_mode_map = {
	\ 'mode': 'passive',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': []
\}

let g:syntastic_vim_checkers = ['vint']
let g:syntastic_javascript_checkers = ['jshint', 'jslint']

" grammar checker
let g:syntastic_text_checkers = ['language_check']
let g:syntastic_text_language_check_args = '--language=en-US'
