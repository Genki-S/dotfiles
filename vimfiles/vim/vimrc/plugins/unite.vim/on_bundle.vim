nnoremap <unique> <SID>[unite] <Nop>
nmap <unique> <Space> <SID>[unite]

nnoremap <unique> <silent> <SID>[unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <unique> <silent> <SID>[unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
nnoremap <unique> <silent> <SID>[unite]B :<C-u>Unite -buffer-name=bookmark bookmark<CR>
nnoremap <unique> <silent> <SID>[unite]c :<C-u>Unite -buffer-name=command command<CR>
nnoremap <unique> <silent> <SID>[unite]f :<C-u>Unite -buffer-name=file file<CR>
nnoremap <unique> <silent> <SID>[unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <unique> <silent> <SID>[unite]l :<C-u>Unite -buffer-name=lazy_bundles neobundle/lazy<CR>
nnoremap <unique> <silent> <SID>[unite]L :<C-u>Unite -buffer-name=line line<CR>
nnoremap <unique> <silent> <SID>[unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>
nnoremap <unique> <silent> <SID>[unite]o :<C-u>Unite -buffer-name=outline outline<CR>
nnoremap <unique> <silent> <SID>[unite]R :<C-u>Unite -buffer-name=register register<CR>
nnoremap <unique> <silent> <SID>[unite]r :<C-u>Unite -buffer-name=reccursive file_rec<CR>
nnoremap <unique> <silent> <SID>[unite]t :<C-u>Unite -buffer-name=tag tag<CR>
nnoremap <unique> <silent> <SID>[unite]<Space> :<C-u>Unite -buffer-name=source source<CR>
