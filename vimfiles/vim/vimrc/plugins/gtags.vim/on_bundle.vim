nnoremap <SID>[gtags] <Nop>
nmap <Leader>G <SID>[gtags]

nnoremap <SID>[gtags]<Space> :Gtags 
" *L*ist symbols in current buffer
nnoremap <silent> <SID>[gtags]l :Gtags -f %<CR>
nnoremap <silent> <SID>[gtags]<C-]> :GtagsCursor<CR>
nnoremap <silent> <C-\><C-]> :GtagsCursor<CR>
