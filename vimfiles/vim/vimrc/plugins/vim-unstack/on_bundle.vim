command! -range Unstack call s:unstack()
function! s:unstack()
	if !neobundle#is_sourced('vim-unstack')
		NeoBundleSource 'vim-unstack'
	endif
	call unstack#Unstack(visualmode())
endfunction
