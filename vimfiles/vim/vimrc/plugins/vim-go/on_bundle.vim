nnoremap <SID>[go] <Nop>
nmap <Leader>G <SID>[go]

nnoremap <silent> <SID>[go]r :GoReferrers<CR>
nnoremap <silent> <SID>[go]i :GoImplements<CR>
nnoremap <silent> <SID>[go]I :GoImpl<CR>
nnoremap <silent> <SID>[go]cr :GoCallers<CR>
nnoremap <silent> <SID>[go]ce :GoCallees<CR>
nnoremap <silent> <SID>[go]cs :GoCallstack<CR>
nnoremap <silent> <SID>[go]e :GoExport<CR>