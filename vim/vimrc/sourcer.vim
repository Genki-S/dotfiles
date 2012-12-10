" This file provides a way to source
" plugins and their settings on demand

function! s:SourceAndExecute(plugin, command, ...)
	let s:args = join(a:000, " ")
	execute "MyNeoBundleSource " . a:plugin
	execute a:command s:args
endfunction

command! -nargs=+
	\ SourceAndExecute
	\ call s:SourceAndExecute(<f-args>)
