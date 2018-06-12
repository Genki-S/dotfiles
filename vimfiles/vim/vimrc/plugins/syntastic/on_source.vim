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

" Java checkers
let g:syntastic_java_checkstyle_classpath = expand("$HOME/dotfiles/submodules/checkstyle/target/checkstyle-6.19-all.jar")
let g:syntastic_java_checkstyle_conf_file = expand("$HOME/dotfiles/miscfiles/checkstyle_checks.xml")
let g:syntastic_java_checkers = ['checkstyle'] " javac check is done with :EclimValidate

" Vim checkers
let g:syntastic_vim_checkers = ['vint']
