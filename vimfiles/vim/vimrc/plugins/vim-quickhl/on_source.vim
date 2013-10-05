nnoremap <SID>[quickhl] <Nop>
nmap <Leader>h <SID>[quickhl]
nmap <SID>[quickhl]t <Plug>(quickhl-toggle)
xmap <SID>[quickhl]t <Plug>(quickhl-toggle)
nmap <SID>[quickhl]r <Plug>(quickhl-reset)
xmap <SID>[quickhl]r <Plug>(quickhl-reset)
nnoremap <silent> <SID>[quickhl]l :QuickhlLock<CR>
nnoremap <silent> <SID>[quickhl]u :QuickhlUnLock<CR>
nnoremap <silent> <SID>[quickhl]s :QuickhlList<CR>

