" Change Leader
let mapleader = ','

" General mappings {{{
" For US keyboard
" See vim-sneak settings
" nnoremap \ ,
" noremap : ;
noremap ; :
" noremap q; q: " don't use this, it makes quit mappings wait
"}}}

" Normal mode mappings {{{
" Be consistent with D and C
nnoremap Y y$

" This might be replaced by ftplugins or plugin mappings (because 'make' means different things)
nnoremap M :make<Enter>

" Q closes.
nnoremap Q :<C-u>q<CR>

" close tab
nnoremap <C-w>Q :tabclose<CR>

" C-w t to create new tab
nnoremap <C-w>t :tabnew<CR>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
" tip: gv selects last selection again

" make ( and ) work with Japanese sentences
nnoremap <silent> ( ?[.。]<CR>:noh<CR>
nnoremap <silent> ) /[.。]<CR>:noh<CR>

" make [[ and ]] work with no {}-at-first-column restriction (:help section)
nnoremap [[ ?{<CR>w99[{
nnoremap ][ /}<CR>b99]}
nnoremap ]] j0?{<CR>w99[{%/{<CR>
nnoremap [] k$/}<CR>b99]}%?}<CR>
"}}}

" Comamnd line mappings {{{
" Emacs style
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Delete>
cnoremap <C-g> <C-c>

" Useful expantions
cnoremap <expr> %P expand("%:p")
cnoremap <expr> %H expand("%:h")
cnoremap <expr> %T expand("%:t")
cnoremap <expr> %R expand("%:t:r")

" Jump into commandline window with <C-t>
cnoremap <C-t> <C-f>
"}}}

" Insert mode mappings {{{
" easy upcase
inoremap <Leader><C-u> <Esc>gUiWgi

" break undo chain when using insert mode deletions
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" emacs keybind
inoremap <C-b> <Left>
inoremap <C-f> <Right>
" ^ is more useful than 0 in many cases
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-k> <C-o>d$
"}}}

" Visual mode mappings {{{
" search with selection
vnoremap * "zy:let @/ = @z<CR>n
vnoremap <Leader>G "zy:Google <C-r>"<CR>
vnoremap <Leader>E "zy:Ref webdict alc <C-r>"<CR>

" Pbcopy
vnoremap <silent> <Leader>Y :Pbcopy<CR>
" }}}

" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>
