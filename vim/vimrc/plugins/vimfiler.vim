nnoremap [vimfiler] <Nop>
nmap <Space> [vimfiler]

nnoremap [vimfiler] :<C-u>VimFiler 
nnoremap <silent> [vimfiler]b :<C-u>VimFilerBufferDir<CR>
nnoremap <silent> [vimfiler]c :<C-u>VimFilerCurrentDir<CR>
nnoremap <silent> [vimfiler]d :<C-u>VimFilerDouble<CR>
nnoremap <silent> [vimfiler]e :<C-u>VimFilerExplorer -buffer-name=explorer -toggle<CR>

let g:vimfiler_as_default_explorer = 1

augroup vimrc_vimfiler
	autocmd!
	autocmd Filetype vimfiler call s:my_vimfiler_settings()
augroup END

function! s:my_vimfiler_settings()
	nmap <buffer> q <Plug>(vimfiler_exit)
	nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction
