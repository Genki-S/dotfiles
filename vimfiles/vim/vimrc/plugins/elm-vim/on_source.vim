if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.elm = '\.'

augroup vimrc_elm-vim
  autocmd!
  autocmd FileType elm nmap <buffer> K <Plug>(elm-show-docs)
augroup END
