nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

let g:grepper = {
  \ 'tools': ['rg', 'git', 'ag', 'grep'],
  \ 'quickfix': 0
\ }

nnoremap <SID>[grepper] <Nop>
" Using 'a' since this is replacing ag.vim
nmap <Leader>a <SID>[grepper]

nnoremap <silent> <SID>[grepper] :<C-u>Grepper<CR>
