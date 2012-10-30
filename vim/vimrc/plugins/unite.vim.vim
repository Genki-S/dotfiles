nnoremap [unite] <Nop>
nmap <Leader>u [unite]

nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]B :<C-u>Unite -buffer-name=bookmark buffer<CR>
nnoremap <silent> [unite]c :<C-u>Unite -buffer-name=command command<CR>
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=file file<CR>
nnoremap <silent> [unite]h :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> [unite]l :<C-u>Unite -buffer-name=lazy_bundles neobundle/lazy<CR>
nnoremap <silent> [unite]L :<C-u>Unite -buffer-name=line line<CR>
nnoremap <silent> [unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>
nnoremap <silent> [unite]o :<C-u>Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]R :<C-u>Unite -buffer-name=reccursive file_rec<CR>
nnoremap <silent> [unite]<Space> :<C-u>Unite -buffer-name=source source<CR>
