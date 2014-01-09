autocmd FileType ruby execute "let b:surround_" . char2nr("#") . " = '#{\r}'"
