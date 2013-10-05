nnoremap <SID>[ref] <Nop>
nmap <Leader>, <SID>[ref]
nnoremap <SID>[ref]a :Ref webdict alc 
nnoremap <SID>[ref]c :Ref webdict collins 
nnoremap <SID>[ref]w :Ref webdict wikipedia 
nnoremap <expr> <SID>[ref]k ":Ref " . ref#detect() . " "
nnoremap <silent> <SID>[ref]K :execute 'Ref webdict alc ' . expand('<cword>')<CR>
