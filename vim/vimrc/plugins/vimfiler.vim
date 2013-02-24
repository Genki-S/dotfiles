let g:vimfiler_as_default_explorer = 1

augroup vimrc_vimfiler
	autocmd!
	autocmd Filetype vimfiler call s:my_vimfiler_settings()
augroup END

function! s:my_vimfiler_settings()
	nmap <buffer> q <Plug>(vimfiler_exit)
	nmap <buffer> Q <Plug>(vimfiler_hide)
	nmap <buffer> <C-h> <Plug>(vimfiler_switch_to_parent_directory)
endfunction
