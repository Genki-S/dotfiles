autocmd FileType yaml let b:switch_definitions =
	\ [
		\ {
			\ '\vhttps://github.com/(.*)': '\1:',
		\ }
	\ ]

autocmd FileType ruby let b:switch_definitions =
	\ [
		\ ['attr_reader', 'attr_writer', 'attr_accessor'],
	\ ]

execute "set filetype=".&filetype
