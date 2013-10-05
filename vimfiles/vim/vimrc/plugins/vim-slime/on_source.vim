let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

let g:slime_no_mappings = 1
nnoremap <SID>[slime] <Nop>
nmap <Leader>s <SID>[slime]
xnoremap <SID>[slime] <Nop>
xmap <Leader>s <SID>[slime]

xmap <silent> <SID>[slime]s <Plug>SlimeRegionSend
nmap <silent> <SID>[slime]s <Plug>SlimeLineSend
nmap <silent> <SID>[slime]p <Plug>SlimeParagraphSend
nmap <silent> <SID>[slime]m <Plug>SlimeMotionSend
nmap <silent> <SID>[slime]a ;<C-u>%SlimeSend<CR>
nmap <silent> <SID>[slime]c <Plug>SlimeConfig
