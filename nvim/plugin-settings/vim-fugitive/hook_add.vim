nnoremap <SID>[fugitive] <Nop>
nmap <Leader>g <SID>[fugitive]

nnoremap <SID>[fugitive]<Space> :Git 
nnoremap <SID>[fugitive]s :Git<CR>
nnoremap <SID>[fugitive]c :Git commit<CR>
nnoremap <SID>[fugitive]C :Git commit --amend<CR>
nnoremap <SID>[fugitive]g :Ggrep 
nnoremap <SID>[fugitive]l :Glog 
nnoremap <SID>[fugitive]e :Gedit 
nnoremap <SID>[fugitive]v :Gvsplit 
nnoremap <SID>[fugitive]t :Gtabedit 
nnoremap <SID>[fugitive]re :Gread<CR>
nnoremap <SID>[fugitive]w :Gwrite<CR>
nnoremap <SID>[fugitive]d :Gdiff 
nnoremap <SID>[fugitive]D :Gdiff master<CR>
nnoremap <SID>[fugitive]mv :Gmove 
nnoremap <SID>[fugitive]rm :Gremove<CR>
nnoremap <SID>[fugitive]b :Git blame -w<CR>
nnoremap <SID>[fugitive]B :Git blame -w -C -C<CR>
