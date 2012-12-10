" ==================================================
" Alter Commands
" ==================================================
augroup altercmd-register
	autocmd VimEnter * AlterCommand marvim MyNeoBundleSource marvim
augroup END


function! s:SID()
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun

nnoremap <unique> <SID>[marvim] <Nop>
nmap <unique> <Leader>m <SID>[marvim]

let s:id = s:SID()

let g:marvim_store = expand('~/.vim/marvim')
let g:marvim_find_key = '<SNR>' . s:id . '_[marvim]f'
let g:marvim_store_key = '<SNR>' . s:id . '_[marvim]s'
let g:marvim_register = 'q'
