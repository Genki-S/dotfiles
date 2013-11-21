inoremap <Leader><C-u> <Esc>gUiWgi

" break undo chain when using insert mode deletions
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

function! g:my_insert_cr_mapping()
	if neobundle#is_sourced('vim-endwise') && neobundle#is_sourced('delimitMate')
		imap <CR> <Plug>delimitMateCR<Plug>DiscretionaryEnd
	elseif neobundle#is_sourced('vim-endwise')
		imap <CR> <Plug>DiscretionaryEnd
	elseif neobundle#is_sourced('delimitMate')
		imap <CR> <Plug>delimitMateCR
	endif
endfunction
