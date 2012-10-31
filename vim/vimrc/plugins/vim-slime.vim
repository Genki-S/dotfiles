let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

let g:slime_no_mappings = 1
nnoremap [slime] <Nop>
nmap <Leader>s [slime]
xnoremap [slime] <Nop>
xmap <Leader>s [slime]

xmap <silent> [slime]s <Plug>SlimeRegionSend
nmap <silent> [slime]s <Plug>SlimeLineSend
nmap <silent> [slime]p <Plug>SlimeParagraphSend
nmap <silent> [slime]m <Plug>SlimeMotionSend
nmap <silent> [slime]a :<C-u>%SlimeSend<CR>
nmap <silent> [slime]c <Plug>SlimeConfig
