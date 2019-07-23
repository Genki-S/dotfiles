let s:repl_command_by_filetype = {
			\ 'elm' : 'elm repl',
			\ 'ruby' : 'pry'
			\ }

function! s:repl() abort
	if (!has_key(s:repl_command_by_filetype, &filetype))
		echoerr "No REPL command defined for filetype:" . &filetype
		return
	endif

	let cmd = s:repl_command_by_filetype[&filetype]
	execute "Start " . cmd
endfunction

command! REPL call <SID>repl()
