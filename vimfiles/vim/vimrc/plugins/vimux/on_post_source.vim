function! VimuxSendTextWithEnter(text)
	call VimuxSendText(a:text)
	call VimuxSendKeys("Enter")
endfunction

function! VimuxSendKeysWithGetcharWithCallback(callback)
	call VimuxSendKeys(Genki_char2tmux(getchar()))
	execute a:callback
endfunction

function! Genki_vimux_buffer_dir()
	if bufname('%') =~# 'vimfiler'
		let buffer_dir = vimfiler#get_current_vimfiler().current_dir
	else
		let buffer_dir = expand('%:p:h')
	end
	call VimuxRunCommand('cd ' . buffer_dir)
endfunction

command! -nargs=* VimuxBufferDir call Genki_vimux_buffer_dir()
