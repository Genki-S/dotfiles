nnoremap <unique> <SID>[ref] <Nop>
nmap <unique> <Leader>, <SID>[ref]
nnoremap <unique> <SID>[ref]a :Ref webdict alc 
nnoremap <unique> <SID>[ref]c :Ref webdict collins 
nnoremap <unique> <SID>[ref]w :Ref webdict wikipedia 
nnoremap <expr> <unique> <SID>[ref]k ":Ref " . ref#detect() . " "
nnoremap <unique> <silent> <SID>[ref]K :execute 'Ref webdict alc ' . expand('<cword>')<CR>
