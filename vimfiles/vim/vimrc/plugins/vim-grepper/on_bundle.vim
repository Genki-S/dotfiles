nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

let g:grepper = {
  \ 'quickfix': 0,
  \ 'tools': ['rg', 'git', 'ag', 'grep'],
  \ 'rg': {
    \ 'grepprg': 'rg --no-heading --vimgrep --smart-case'
  \ }
\ }

nnoremap <SID>[grepper] <Nop>
" Using 'a' since this is replacing ag.vim
nmap <Leader>a <SID>[grepper]

nnoremap <silent> <SID>[grepper] :<C-u>Grepper<CR>
