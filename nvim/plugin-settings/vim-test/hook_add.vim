let g:test#strategy = 'dispatch'

nnoremap <SID>[test] <Nop>
nmap <Leader>t <SID>[test]

nnoremap <silent> <SID>[test]n :<C-u>TestNearest \| call lightline#update()<CR>
nnoremap <silent> <SID>[test]f :<C-u>TestFile \| call lightline#update()<CR>
nnoremap <silent> <SID>[test]s :<C-u>TestSuite \| call lightline#update()<CR>
nnoremap <silent> <SID>[test]l :<C-u>TestLast \| call lightline#update()<CR>
nnoremap <silent> <SID>[test]v :<C-u>TestVisit<CR>

let test#custom_runners = {
  \ 'Gdscript': ['Gut']
\ }

let g:dispatch_compilers = {}
let g:dispatch_compilers['gut-runner-quickfix'] = 'gut_runner_quickfix'
