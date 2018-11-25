call denite#custom#map(
			\ 'insert',
			\ '<C-n>',
			\ '<denite:move_to_next_line>',
			\ 'noremap'
			\)
call denite#custom#map(
			\ 'insert',
			\ '<C-p>',
			\ '<denite:move_to_previous_line>',
			\ 'noremap'
			\)

" use ag for file/rec (:h denite-examples)
call denite#custom#var('file/rec', 'command',
			\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" use ripgrep for grep (:h denite-examples)
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
			\ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
