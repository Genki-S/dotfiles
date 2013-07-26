autocmd FileType vim let b:switch_definitions =
	\ [
		\ ['NeoBundle', 'NeoBundleLazy'],
		\ {
			\ 'https://github.com/\(.*\)': 'NeoBundle ''\1''',
		\ }
	\ ]

autocmd FileType ruby let b:switch_definitions =
	\ [
		\ ['attr_reader', 'attr_writer', 'attr_accessor'],
	\ ]

execute "set filetype=".&filetype
