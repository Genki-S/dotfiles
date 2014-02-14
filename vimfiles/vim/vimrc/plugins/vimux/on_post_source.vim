function! VimuxSendTextWithEnter(text)
	call VimuxSendText(a:text)
	call VimuxSendKeys("Enter")
endfunction

function! VimuxSendKeysWithGetchar(callback)
	call VimuxSendKeys(g:genki_char2tmux(getchar()))
	execute a:callback
endfunction

function! g:genki_char2tmux(char)
	let keymap = {
				\ 13 : "Enter",
				\ 32 : "Space",
				\ 27 : "Escape",
				\ }
	return get(keymap, a:char, nr2char(a:char))
endfunction

" args: command to run first
function! g:genki_vimux_prompt_mode(args)
	edit _VimuxPrompt_
	call VimuxRunCommand(a:args)

	" mappings
	nnoremap <buffer> <silent> <CR> :call VimuxSendTextWithEnter(getline('.'))<CR>
	inoremap <buffer> <silent> <CR> <Esc>:call VimuxSendTextWithEnter(getline('.'))<CR>o
	nnoremap <buffer> <silent> <nowait> <Leader> :call VimuxSendKeys(g:genki_char2tmux(getchar()))<CR>
	inoremap <buffer> <silent> <expr> <nowait> <Leader> getline('.')=='' ? '<ESC>:call VimuxSendKeysWithGetchar("startinsert")<CR>' : ','

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
