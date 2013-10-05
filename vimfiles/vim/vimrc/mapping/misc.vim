" M to make
nnoremap M :make<Enter>

" make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" plain paste
nnoremap <Leader>pp :<C-u>r !cat<CR>

" Wise quit
nnoremap <silent> Q :call <SID>wise_quit()<CR>
function! s:wise_quit()
	if bufname("%") == "[Command Line]"
		q
		return
	endif
	if &l:modifiable && &l:modified
		w
	endif
	bd
	let l:bls = tabpagebuflist()
	if len(l:bls) == 1 && bufname(l:bls[0]) ==# ""
		q
	endif
endfunction
