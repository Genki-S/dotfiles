nnoremap <unique> <silent> - :SourceAndExecute switch.vim Switch<CR>

autocmd FileType vim let b:switch_definitions =
	\ [
		\ ['NeoBundle', 'NeoBundleLazy'],
	\ ]
