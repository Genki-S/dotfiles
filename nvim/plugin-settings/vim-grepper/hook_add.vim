nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <SID>[grepper] <Nop>
" 'a' is for ack / ag -- 'g' is taken by git and go
nmap <Leader>a <SID>[grepper]

nnoremap <SID>[grepper] :<C-u>Grepper<CR>
