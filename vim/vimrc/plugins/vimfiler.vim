nnoremap <SID>[vimfiler] <Nop>
nmap <Space> <SID>[vimfiler]

nnoremap <SID>[vimfiler] :<C-u>VimFiler 
nnoremap <silent> <SID>[vimfiler]b :<C-u>VimFilerBufferDir<CR>
nnoremap <silent> <SID>[vimfiler]c :<C-u>VimFilerCurrentDir<CR>
nnoremap <silent> <SID>[vimfiler]d :<C-u>VimFilerDouble<CR>
nnoremap <silent> <SID>[vimfiler]e :<C-u>VimFilerExplorer -buffer-name=explorer -toggle<CR>

let g:vimfiler_as_default_explorer = 1

augroup vimrc_vimfiler
	autocmd!
	autocmd Filetype vimfiler call s:my_vimfiler_settings()
augroup END

function! s:my_vimfiler_settings()
	nmap <buffer> q <Plug>(vimfiler_exit)
	nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction
