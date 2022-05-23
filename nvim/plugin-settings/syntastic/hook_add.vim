nnoremap <Leader><CR> <Cmd>SyntasticCheck<CR>

augroup vimrc_syntastic
  autocmd!
  autocmd BufWritePost * SyntasticCheck | call lightline#update()
augroup END
