augroup vimrc_emmet-vim
  autocmd!
  autocmd FileType html,erb,haml,css,scss call s:map_emmet()
augroup END

function! s:map_emmet()
  " expand neosnippet snippet if possible, falling back to emmet expansion
  imap <buffer> <expr> <C-k> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<Plug>(emmet-expand-abbr)"
endfunction
