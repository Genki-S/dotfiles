nnoremap <SID>[denite] <Nop>
nmap <Space> <SID>[denite]

nnoremap <silent> <SID>[denite]r <Cmd>Denite -start-filter file/rec<CR>
" m for MRU
nnoremap <silent> <SID>[denite]m <Cmd>Denite -start-filter file_mru<CR>
nnoremap <silent> <SID>[denite]g <Cmd>Denite -start-filter -smartcase -no-empty grep<CR>
nnoremap <silent> <SID>[denite]l <Cmd>Denite -start-filter line<CR>
nnoremap <silent> <SID>[denite]b <Cmd>Denite -start-filter buffer<CR>
