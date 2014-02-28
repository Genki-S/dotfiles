" Normal mode mappings {{{
" This might be replaced by ftplugins or plugin mappings (because 'make' means different things)
nnoremap M :make<Enter>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
" tip: gv selects last selection again

" plain paste
nnoremap <Leader>pp :<C-u>r !cat<CR>

" make ( and ) work with Japanese sentences
nnoremap <silent> ( ?[.。]<CR>:noh<CR>
nnoremap <silent> ) /[.。]<CR>:noh<CR>
"}}}

" Comamnd line mappings {{{
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>
cnoremap <expr> %% expand("%:p:h") . "/"
"}}}

" Insert mode mappings {{{
" easy upcase
inoremap <Leader><C-u> <Esc>gUiWgi

" break undo chain when using insert mode deletions
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>
"}}}

" Next Text Object {{{
onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
function! s:NextTextObject(motion, dir)
	let c = nr2char(getchar())
	if c ==# "b"
		let c = "("
	elseif c ==# "B"
		let c = "{"
	elseif c ==# "d"
		let c = "["
	endif
	exe "normal! ".a:dir.c."v".a:motion.c
endfunction
"}}}

" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>
