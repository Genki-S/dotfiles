nnoremap <unique> <SID>[quickhl] <Nop>
nmap <unique> <Leader>h <SID>[quickhl]
nmap <unique> <SID>[quickhl]t <Plug>(quickhl-toggle)
xmap <unique> <SID>[quickhl]t <Plug>(quickhl-toggle)
nmap <unique> <SID>[quickhl]r <Plug>(quickhl-reset)
xmap <unique> <SID>[quickhl]r <Plug>(quickhl-reset)
nnoremap <unique> <silent> <SID>[quickhl]l :QuickhlLock<CR>
nnoremap <unique> <silent> <SID>[quickhl]u :QuickhlUnLock<CR>
nnoremap <unique> <silent> <SID>[quickhl]s :QuickhlList<CR>

