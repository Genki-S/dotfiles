nnoremap <SID>[unite] <Nop>
nmap <Leader>u <SID>[unite]

nnoremap <silent> <SID>[unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> <SID>[unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite]B :<C-u>Unite -buffer-name=bookmark bookmark<CR>
nnoremap <silent> <SID>[unite]c :<C-u>Unite -buffer-name=command command<CR>
nnoremap <silent> <SID>[unite]f :<C-u>Unite -buffer-name=file file<CR>
nnoremap <silent> <SID>[unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> <SID>[unite]l :<C-u>Unite -buffer-name=lazy_bundles neobundle/lazy<CR>
nnoremap <silent> <SID>[unite]L :<C-u>Unite -buffer-name=line line<CR>
nnoremap <silent> <SID>[unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>
nnoremap <silent> <SID>[unite]o :<C-u>Unite -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <SID>[unite]R :<C-u>Unite -buffer-name=reccursive file_rec<CR>
nnoremap <silent> <SID>[unite]<Space> :<C-u>Unite -buffer-name=source source<CR>
