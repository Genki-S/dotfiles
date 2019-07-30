augroup vimrc_vim-lookup
  autocmd!
  autocmd FileType vim nnoremap <buffer> <silent> <C-]> :call lookup#lookup()<CR>
  autocmd FileType vim nnoremap <buffer> <silent> <C-t> :call lookup#pop()<CR>
augroup END
