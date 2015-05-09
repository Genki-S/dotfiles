augroup vimrc
	autocmd!
	autocmd CmdwinEnter * startinsert
	autocmd WinEnter * checktime
	" jump to last position in file
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
	" Auto make directories on save
	autocmd BufWritePre,FileWritePre *
		\ if !isdirectory(expand("<afile>:p:h")) |
		\   call mkdir(expand("<afile>:p:h"), "p") |
		\ endif
	autocmd FileType gitrebase
		\ nnoremap <buffer> p :Pick<CR>|
		\ nnoremap <buffer> s :Squash<CR>|
		\ nnoremap <buffer> e :Edit<CR>|
		\ nnoremap <buffer> r :Reword<CR>|
		\ nnoremap <buffer> f :Fixup<CR>
	autocmd BufWritePost *
		\ if getline(1) =~ "^#!" && getline(1) =~ "/bin/" |
		\   call Genki_chmod('a+x', expand("<afile>:p")) |
		\ endif
	" This has a lag and I had better control IME myself
	" if has('mac')
		" autocmd InsertLeave * call system('osx-ime-to-eisuu')
	" endif
augroup END

augroup vimrc_plugins
	autocmd!
	autocmd User sourced_neocomplete
		\ for ft in keys(g:neocomplete#text_mode_filetypes)
			\| execute 'autocmd FileType' ft 'setlocal spell'
		\| endfor
augroup END
