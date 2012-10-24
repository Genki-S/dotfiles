" ==================================================
" Make it easy to make it easy
" ==================================================
nnoremap [edit] <Nop>
nmap <Leader>e [edit]
nnoremap [edit]v :tabnew $MYVIMRC<CR>
nnoremap [edit]s :N

nnoremap [source] <Nop>
nmap <Leader>s [source]
nnoremap [source]v :source $MYVIMRC<CR>

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
