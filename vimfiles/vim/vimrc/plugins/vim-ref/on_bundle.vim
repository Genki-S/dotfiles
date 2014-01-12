AlterCommand man Ref man

nnoremap <SID>[ref] <Nop>
nmap <Leader>, <SID>[ref]
nnoremap <SID>[ref]a :Ref webdict alc 
nnoremap <SID>[ref]c :Ref webdict collins 
nnoremap <SID>[ref]w :Ref webdict wikipedia 
nnoremap <expr> <SID>[ref], ':Ref ' . ref#detect() . ' '
nnoremap <silent> <SID>[ref]K :execute 'Ref ' . ref#detect() . ' ' . expand('<cword>')<CR>
