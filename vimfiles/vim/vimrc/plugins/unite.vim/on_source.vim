let g:unite_enable_start_insert = 1
let g:unite_force_overwrite_statusline = 0

" Make 'find' follow symlinks
let g:unite_source_find_default_opts = '-L'

" grep settings
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts =
		\ '--line-numbers --nogroup --nocolor --follow --hidden --ignore-case --ignore ".git" --ignore ".bzr"'
	let g:unite_source_grep_recursive_opt = ''
endif
