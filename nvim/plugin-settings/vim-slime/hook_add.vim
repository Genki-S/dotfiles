let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

let g:slime_no_mappings = 1
nnoremap <SID>[slime] <Nop>
nmap <Leader>s <SID>[slime]
xnoremap <SID>[slime] <Nop>
xmap <Leader>s <SID>[slime]

function! s:my_slime_config() abort
	:SlimeConfig
	echomsg "[vim-slime hook_add] mapping keys for slime"
	map <buffer> <silent> <CR> <Plug>SlimeLineSend
	xmap <silent> <SID>[slime]s <Plug>SlimeRegionSend
	nmap <silent> <SID>[slime]s <Plug>SlimeLineSend
	nmap <silent> <SID>[slime]p <Plug>SlimeParagraphSend
	nmap <silent> <SID>[slime]m <Plug>SlimeMotionSend
	nmap <silent> <SID>[slime]a <Cmd>%SlimeSend<CR>
endfunction

command! -nargs=0 MySlimeConfig call s:my_slime_config()
nnoremap <silent> <SID>[slime]c :MySlimeConfig<CR>
