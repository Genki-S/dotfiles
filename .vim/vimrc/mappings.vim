" ==================================================
" Make it easy to make it easy
" ==================================================
nnoremap [edit] <Nop>
nmap <Leader>e [edit]
nnoremap [edit]v :tabnew $MYVIMRC<CR>

nnoremap [source] <Nop>
nmap <Leader>s [source]
nnoremap [source]v :source $MYVIMRC<CR>

" ==================================================
" Motions
" ==================================================
" brace movement for programming languages (override sentence motion)
onoremap ) t)
onoremap ( t(
vnoremap ) t)
vnoremap ( t(

" ==================================================
" Insert Mode Mappings
" ==================================================
inoremap <Leader><C-u> <Esc>gUiWEa
