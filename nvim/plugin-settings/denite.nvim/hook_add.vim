nnoremap <SID>[denite] <Nop>
nmap <Space> <SID>[denite]

nnoremap <silent> <SID>[denite]r <Cmd>Denite file/rec<CR>
" m for MRU
nnoremap <silent> <SID>[denite]m <Cmd>Denite file/old<CR>
nnoremap <silent> <SID>[denite]g <Cmd>Denite grep -auto-preview -smartcase -no-empty<CR>
nnoremap <silent> <SID>[denite]l <Cmd>Denite line<CR>
