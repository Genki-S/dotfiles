nnoremap <unique> <SID>[vimfiler] <Nop>
nmap <unique> <Space> <SID>[vimfiler]

nnoremap <unique> <SID>[vimfiler]<Space> :<C-u>VimFiler 
nnoremap <unique> <silent> <SID>[vimfiler]b :<C-u>VimFilerBufferDir<CR>
nnoremap <unique> <silent> <SID>[vimfiler]c :<C-u>VimFilerCurrentDir<CR>
nnoremap <unique> <silent> <SID>[vimfiler]d :<C-u>VimFilerDouble<CR>
nnoremap <unique> <silent> <SID>[vimfiler]e :<C-u>VimFilerExplorer -buffer-name=explorer -toggle<CR>

let g:vimfiler_as_default_explorer = 1

augroup vimrc_vimfiler
	autocmd!
	autocmd Filetype vimfiler call s:my_vimfiler_settings()
augroup END

function! s:my_vimfiler_settings()
	nmap <unique> <buffer> q <Plug>(vimfiler_exit)
	nmap <unique> <buffer> Q <Plug>(vimfiler_hide)
endfunction
