function! VimuxSendTextWithEnter(text)
	call VimuxSendText(a:text)
	call VimuxSendKeys("Enter")
endfunction

" args: command to run first
function! g:genki_vimux_prompt_mode(args)
	tabnew _VimuxPrompt_
	call VimuxRunCommand(a:args)

	" mappings
	inoremap <buffer> <silent> <Enter> <Esc>:call VimuxSendTextWithEnter(getline('.'))<CR>o

	" buffer settings
	setlocal buftype=nofile
	setlocal nobuflisted
	setlocal noswapfile
	setlocal bufhidden=delete
	setlocal nonumber
	setlocal nowrap

	startinsert
endfunction

" augroup vimux_prompt_mode
	" autocmd!
	" autocmd BufWipeout _VimuxPrompt_
		" \ execute "save ~/.tmp/vim/vimux_prompt_" . localtime()
		" \| VimuxCloseRunner
" augroup END

command! -nargs=* VimuxPromptMode call g:genki_vimux_prompt_mode(<q-args>)
AlterCommand vpm ViuxPromptMode
