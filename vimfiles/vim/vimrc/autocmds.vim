augroup vimrc
	autocmd!
	autocmd CmdwinEnter * startinsert
	autocmd WinEnter * checktime
	" jump to last position in file
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
augroup END

augroup vimrc_plugins
	autocmd!
	autocmd User sourced_neocomplete
		\ for ft in keys(g:neocomplete#text_mode_filetypes)
			\| execute 'autocmd FileType' ft 'setlocal spell'
		\| endfor
augroup END
