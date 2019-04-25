nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <SID>[grepper] <Nop>
nmap <Leader>G <SID>[grepper]

nnoremap <silent> <SID>[grepper] :<C-u>Grepper<CR>
