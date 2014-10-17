let g:unite_force_overwrite_statusline = 0
let g:unite_source_history_yank_enable = 1

nnoremap <SID>[unite] <Nop>
nmap <Space> <SID>[unite]

nnoremap <silent> <SID>[unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> <SID>[unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> <SID>[unite]B :<C-u>Unite -buffer-name=bookmark bookmark<CR>
nnoremap <silent> <SID>[unite]c :<C-u>Unite -buffer-name=compiler compiler<CR>
nnoremap <silent> <SID>[unite]C :<C-u>Unite -buffer-name=command command<CR>
nnoremap <SID>[unite]e :<C-u>Unite -buffer-name=english english_
nnoremap <silent> <SID>[unite]f :<C-u>UniteWithBufferDir -buffer-name=file file<CR>
nnoremap <expr> <silent> <SID>[unite]F ":<C-u>Unite -buffer-name=file -input=" . expand("%:p:r:r:r") . " file<CR>"
nnoremap <SID>[unite]h :<C-u>Unite -buffer-name=history history/
nnoremap <silent> <SID>[unite]H :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> <SID>[unite]l :<C-u>Unite -buffer-name=location_list location_list<CR>
nnoremap <silent> <SID>[unite]L :<C-u>Unite -buffer-name=line line<CR>
nnoremap <silent> <SID>[unite]m :<C-u>Unite -buffer-name=mru file_mru<CR>
nnoremap <silent> <SID>[unite]M :<C-u>Unite -buffer-name=mark mark<CR>
nnoremap <silent> <SID>[unite]o :<C-u>Unite -buffer-name=outline outline<CR>
nnoremap <silent> <SID>[unite]r :<C-u>Unite -buffer-name=file_rec file_rec/async<CR>
nnoremap <silent> <SID>[unite]R :<C-u>Unite -buffer-name=quicklearn quicklearn -immediately<Cr>
nnoremap <silent> <SID>[unite]s :<C-u>Unite -buffer-name=snippet snippet<CR>
nnoremap <silent> <SID>[unite]y :<C-u>Unite -buffer-name=yank history/yank<CR>
nnoremap <silent> <SID>[unite]q :<C-u>Unite -buffer-name=quickfix quickfix<CR>
nnoremap <silent> <SID>[unite]Q :<C-u>UniteClose<CR>
nnoremap <silent> <SID>[unite]<Space> :<C-u>Unite -buffer-name=source source<CR>

" unite-tag
nnoremap <silent> <SID>[unite]t :<C-u>Unite -buffer-name=tag tag<CR>
nnoremap <silent> <SID>[unite]<C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>

" vim-unite-giti
nnoremap <silent> <SID>[unite]g<Space> :<C-u>Unite -buffer-name=giti giti<CR>
nnoremap <silent> <SID>[unite]gb :<C-u>Unite -buffer-name=giti giti/branch<CR>
nnoremap <silent> <SID>[unite]gB :<C-u>Unite -buffer-name=giti giti/branch_all<CR>
nnoremap <silent> <SID>[unite]gc :<C-u>Unite -buffer-name=giti giti/config<CR>
nnoremap <silent> <SID>[unite]gl :<C-u>Unite -buffer-name=giti giti/log<CR>
nnoremap <silent> <SID>[unite]gr :<C-u>Unite -buffer-name=giti giti/remote<CR>
nnoremap <silent> <SID>[unite]gs :<C-u>Unite -buffer-name=giti giti/status<CR>

" unite-ghq
nnoremap <silent> <SID>[unite]G :<C-u>Unite -buffer-name=ghq ghq<CR>
