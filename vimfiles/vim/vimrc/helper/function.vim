function! g:shell_command_exists(command)
	call system("which -s ".a:command)
	return v:shell_error == 0
endfunction
