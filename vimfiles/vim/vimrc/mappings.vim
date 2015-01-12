" Normal mode mappings {{{
" Be consistent with D and C
nnoremap Y y$

" This might be replaced by ftplugins or plugin mappings (because 'make' means different things)
nnoremap M :make<Enter>

" Q closes.
nnoremap Q :<C-u>q<CR>

" close tab
nnoremap <C-w>Q :tabclose<CR>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
" tip: gv selects last selection again

" Pbcopy
vnoremap <silent> <Leader>Y :Pbcopy<CR>

" make ( and ) work with Japanese sentences
nnoremap <silent> ( ?[.。]<CR>:noh<CR>
nnoremap <silent> ) /[.。]<CR>:noh<CR>
"}}}

" Comamnd line mappings {{{
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Delete>
cnoremap <C-g> <C-c>
cnoremap <C-t> <C-f>
cnoremap <expr> %P expand("%:p")
cnoremap <expr> %H expand("%:h")
cnoremap <expr> %T expand("%:t")
cnoremap <expr> %R expand("%:t:r")
"}}}

" Insert mode mappings {{{
" easy upcase
inoremap <Leader><C-u> <Esc>gUiWgi

" break undo chain when using insert mode deletions
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
"}}}

" Visual mode mappings {{{
" search with selection
vnoremap * "zy:let @/ = @z<CR>n
vnoremap <Leader>G "zy:Google <C-r>"<CR>
vnoremap <Leader>E "zy:Ref webdict alc <C-r>"<CR>
" }}}

" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>
