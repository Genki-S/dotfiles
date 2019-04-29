function LC_maps()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
		nnoremap <buffer> <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
	endif
endfunction

augroup vimrc_LanguageClient-neovim
	autocmd!
	autocmd FileType * call LC_maps()
augroup END

" call this here for first plugin load, since FileType is already triggered at this point
call LC_maps()
