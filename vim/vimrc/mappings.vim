" ==================================================
" Make it easy to make it easy
" ==================================================
nnoremap <SID>[edit] <Nop>
nmap <Leader>e <SID>[edit]
nnoremap <SID>[edit]v :tabnew $MYVIMRC<CR>
nnoremap <SID>[edit]s :N

nnoremap <SID>[source] <Nop>
nmap <Leader>S <SID>[source]
nnoremap <SID>[source]v :source $MYVIMRC<CR>

" ==================================================
" Misc.
" ==================================================
" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" ==================================================
" Insert Mode Mappings
" ==================================================
inoremap <Leader><C-u> <Esc>gUiWEa

" ==================================================
" Japanese
" ==================================================
" make ( and ) work with Japanese sentences
nnoremap <silent> ( ?[.。]<CR>:noh<CR>
nnoremap <silent> ) /[.。]<CR>:noh<CR>
