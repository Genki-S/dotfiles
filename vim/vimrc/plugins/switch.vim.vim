nnoremap <unique> - :Switch<CR>

autocmd FileType vim let b:switch_definitions =
	\ [
		\ ['NeoBundle', 'NeoBundleLazy'],
	\ ]
