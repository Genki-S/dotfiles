nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <SID>[grepper] <Nop>
" 'a' is for ack / ag -- 'g' is taken by git and go
nmap <Leader>a <SID>[grepper]

nnoremap <SID>[grepper]c :<C-u>Grepper -dir cwd<CR>
nnoremap <SID>[grepper]f :<C-u>Grepper -dir file<CR>

" 'g'repper 't'ab
" it's unlikely I use operators with this, so implementing this simple
xnoremap gt :<C-u>call <SID>grepper_newtab()<CR>

function! s:grepper_newtab() abort
  let w = getregion(getpos("'<"), getpos("'>"))[0]
  tabnew
  augroup vimrc_grepper-newtab
    autocmd!
    autocmd User Grepper call s:grepper_newtab_after()
  augroup END
  execute "Grepper -noprompt -dir cwd -query " . w
endfunction

function! s:grepper_newtab_after() abort
  if !empty(getloclist(0))
    lfirst
  endif
  augroup vimrc_grepper-newtab
    autocmd!
  augroup END
endfunction
