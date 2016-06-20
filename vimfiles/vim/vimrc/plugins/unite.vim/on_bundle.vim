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

" unite-gtags
"   gtags-all
nnoremap <silent> <SID>[unite]ga :<C-u>Unite -buffer-name=gtags -default-action=list_definitions gtags/completion<CR>
nnoremap <silent> <SID>[unite]gr :<C-u>Unite -buffer-name=gtags -default-action=persist_open gtags/ref<CR>
nnoremap <silent> <SID>[unite]gd :<C-u>Unite -buffer-name=gtags gtags/def<CR>
nnoremap <silent> <SID>[unite]gg :<C-u>Unite -buffer-name=gtags gtags/grep<CR>
nnoremap <silent> <SID>[unite]gf :<C-u>Unite -buffer-name=gtags gtags/file<CR>
nnoremap <silent> <SID>[unite]gp :<C-u>Unite -buffer-name=gtags gtags/path<CR>

" vim-unite-giti
nnoremap <silent> <SID>[unite]G<Space> :<C-u>Unite -buffer-name=giti giti<CR>
nnoremap <silent> <SID>[unite]Gb :<C-u>Unite -buffer-name=giti giti/branch<CR>
nnoremap <silent> <SID>[unite]GB :<C-u>Unite -buffer-name=giti giti/branch_all<CR>
nnoremap <silent> <SID>[unite]Gc :<C-u>Unite -buffer-name=giti giti/config<CR>
nnoremap <silent> <SID>[unite]Gl :<C-u>Unite -buffer-name=giti giti/log<CR>
nnoremap <silent> <SID>[unite]Gr :<C-u>Unite -buffer-name=giti giti/remote<CR>
nnoremap <silent> <SID>[unite]Gs :<C-u>Unite -buffer-name=giti giti/status<CR>
