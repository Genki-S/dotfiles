augroup vimrc_QFGrep
	autocmd!
	autocmd FileType qf nmap <buffer> <Leader>g <Plug>QFGrepG
	autocmd FileType qf nmap <buffer> <Leader>v <Plug>QFGrepV
	autocmd FileType qf nmap <buffer> <Leader>r <Plug>QFRestore
augroup END
