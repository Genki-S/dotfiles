function! s:SID()
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

nnoremap <SID>[marvim] <Nop>
nmap <Leader>m <SID>[marvim]

let s:id = s:SID()

let g:marvim_store = expand('~/.vim/marvim')
let g:marvim_find_key = '<SNR>' . s:id . '_[marvim]f'
let g:marvim_store_key = '<SNR>' . s:id . '_[marvim]s'
let g:marvim_register = 'q'
