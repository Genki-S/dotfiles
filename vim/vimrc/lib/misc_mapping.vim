" make & trigger :&& so it preserves flags
nnoremap <unique> & :&&<Enter>
xnoremap <unique> & :&&<Enter>

" select last paste in visual mode
nnoremap <unique> <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
