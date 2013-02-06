nnoremap <unique> <SID>[source] <Nop>
nmap <unique> <Leader>S <SID>[source]
nnoremap <unique> <SID>[source]v :source $MYVIMRC<CR>

nnoremap <unique> <SID>[edit] <Nop>
nmap <unique> <Leader>e <SID>[edit]
nnoremap <unique> <SID>[edit]v :tabnew $MYVIMRC<CR>
nnoremap <unique> <SID>[edit]s :N
