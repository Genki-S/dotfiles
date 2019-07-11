" Stole from vim-go
" https://github.com/fatih/vim-go/blob/9a7cf4a68adcc9327af33cd1449e7859c0e32af8/autoload/go/util.vim#L318-L328
function! g:Neosnippet_go_json_tagname() abort
  let word = matchstr(getline('.'), '\w\+')
  let word = substitute(word, '::', '/', 'g')
  let word = substitute(word, '\(\u\+\)\(\u\l\)', '\1_\2', 'g')
  let word = substitute(word, '\(\l\|\d\)\(\u\)', '\1_\2', 'g')
  let word = substitute(word, '[.-]', '_', 'g')
  let word = tolower(word)
  return word
endfunction
