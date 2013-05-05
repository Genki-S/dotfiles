autocmd FileType vim let b:switch_definitions =
	\ [
		\ ['NeoBundle', 'NeoBundleLazy'],
		\ {
			\ 'https://github.com/\(.*\)': 'NeoBundle ''\1''',
		\ }
	\ ]

execute "set filetype=".&filetype
