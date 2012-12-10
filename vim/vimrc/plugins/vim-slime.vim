let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

let g:slime_no_mappings = 1
nnoremap <unique> <SID>[slime] <Nop>
nmap <unique> <Leader>s <SID>[slime]
xnoremap <unique> <SID>[slime] <Nop>
xmap <unique> <Leader>s <SID>[slime]

xmap <unique> <silent> <SID>[slime]s <Plug>SlimeRegionSend
nmap <unique> <silent> <SID>[slime]s <Plug>SlimeLineSend
nmap <unique> <silent> <SID>[slime]p <Plug>SlimeParagraphSend
nmap <unique> <silent> <SID>[slime]m <Plug>SlimeMotionSend
nmap <unique> <silent> <SID>[slime]a :<C-u>%SlimeSend<CR>
nmap <unique> <silent> <SID>[slime]c <Plug>SlimeConfig
