let g:test#strategy = 'dispatch'

nnoremap <SID>[test] <Nop>
nmap M <SID>[test]

nnoremap <silent> <SID>[test]n :<C-u>TestNearest<CR>
nnoremap <silent> <SID>[test]f :<C-u>TestFile<CR>
nnoremap <silent> <SID>[test]s :<C-u>TestSuite<CR>
nnoremap <silent> <SID>[test]l :<C-u>TestLast<CR>
nnoremap <silent> <SID>[test]v :<C-u>TestVisit<CR>
