" override codeium#RedrawStatusLine to use it with lightline
function! codeium#RedrawStatusLine() abort
  call lightline#update()
endfunction
