nnoremap [unite] <Nop>
nmap <Space> [unite]

nnoremap <silent> [unite]b :Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]f :Unite -buffer-name=file file<CR>
nnoremap <silent> [unite]m :Unite -buffer-name=mru file_mru<CR>
nnoremap <silent> [unite]r :Unite -buffer-name=reccursive file_rec<CR>
nnoremap <silent> [unite]R :Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]c :Unite -buffer-name=command command<CR>
nnoremap <silent> [unite]l :Unite -buffer-name=line line<CR>
nnoremap <silent> [unite]B :Unite -buffer-name=lazy_bundles neobundle/lazy<CR>
nnoremap <silent> [unite]h :Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]<Space> :Unite -buffer-name=source source<CR>

nnoremap <silent> [unite]o :Unite -buffer-name=outline outline<CR>
