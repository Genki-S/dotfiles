augroup vimrc
	autocmd!
	autocmd CmdwinEnter * startinsert
	autocmd WinEnter * checktime
augroup END

augroup vimrc_plugins
	autocmd!
	autocmd User sourced_neocomplete
		\ for ft in keys(g:neocomplete#text_mode_filetypes)
			\| execute 'autocmd FileType' ft 'setlocal spell'
		\| endfor
augroup END
