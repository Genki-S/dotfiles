nnoremap <unique> <SID>[fugitive] <Nop>
nmap <unique> <Leader>g <SID>[fugitive]
nnoremap <unique> <SID>[fugitive]<Space> :Git 
nnoremap <unique> <SID>[fugitive]s :Gstatus<CR>
nnoremap <unique> <SID>[fugitive]c :Gcommit<CR>
nnoremap <unique> <SID>[fugitive]C :Git commit --amend<CR>
nnoremap <unique> <SID>[fugitive]g :Ggrep 
nnoremap <unique> <SID>[fugitive]l :Glog 
nnoremap <unique> <SID>[fugitive]e :Gedit 
nnoremap <unique> <SID>[fugitive]v :Gvsplit 
nnoremap <unique> <SID>[fugitive]t :Gtabedit 
nnoremap <unique> <SID>[fugitive]re :Gread<CR>
nnoremap <unique> <SID>[fugitive]w :Gwrite<CR>
nnoremap <unique> <SID>[fugitive]d :Gdiff 
nnoremap <unique> <SID>[fugitive]m :Gmove 
nnoremap <unique> <SID>[fugitive]rm :Gremove<CR>
nnoremap <unique> <SID>[fugitive]b :Gblame<CR>
