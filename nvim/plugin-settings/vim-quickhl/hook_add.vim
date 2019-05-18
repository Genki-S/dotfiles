nnoremap <SID>[quickhl] <Nop>
nmap <Leader>h <SID>[quickhl]
nmap <SID>[quickhl]<Space> <Plug>(quickhl-manual-toggle)
xmap <SID>[quickhl]<Space> <Plug>(quickhl-manual-toggle)
nmap <SID>[quickhl]t <Plug>(quickhl-manual-this)
xmap <SID>[quickhl]t <Plug>(quickhl-manual-this)
nnoremap <SID>[quickhl]a :QuickhlManualAdd 
nnoremap <SID>[quickhl]d :QuickhlManualDelete 
nnoremap <SID>[quickhl]r :QuickhlManualReset
nnoremap <silent> <SID>[quickhl]l :QuickhlManualList<CR>
