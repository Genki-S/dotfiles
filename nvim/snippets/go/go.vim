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


" Stole from neosnippet-snippets
" https://github.com/Shougo/neosnippet-snippets/blob/25dbe4ac607580fa05940dae24e544147d0bafeb/neosnippets/go.vim
function! g:Neosnippet_go_iferr() abort
  let re_func = '\vfunc'
  let re_type = '%(%([.A-Za-z0-9*]|\[|\]|%(%(struct)|%(interface)\{\}))+)'
  let re_rcvr = '%(\s*\(\w+\s+' . re_type . '\))?'
  let re_name = '%(\s*\w+)?'
  let re_arg  = '\(%(\w+%(\s+%(\.\.\.)?' . re_type . ')?\s*,?\s*)*\)'

  let re_ret_v = '%(\w+)'
  let re_ret  = '%(\s*\(?(\s*\*?[a-zA-Z0-9_. ,]+)\)?\s*)?'
  let re_ret_body = '%(' . re_ret_v . '|%(' . re_ret_v  . '\s*' . re_type . ')|' . re_type . '\s*,?\s*)*'
  let re_ret  = '%(\s*\(?\s*(' . re_ret_body . ')\)?\s*)?'
  let re = re_func . re_rcvr . re_name . re_arg . re_ret . '\{'

  let lnum = line('.')
  let ret = ""
  while lnum > 0
    let lnum -= 1

    let ma = matchlist(getline(lnum), re)
    if empty(ma)
      continue
    endif
    let ret = ma[1]
    break
  endwhile

  if ret =~ '\v^\s*$'
    return '${1}'
  endif

  let rets = []
  for t in split(ret, ',')
    if t =~# '\v^\s*error\s*$'
      let v = 'err'
    elseif t =~# '\v^\s*string\s*$'
      let v = '"${1\}"'
    elseif t =~# '\v^\s*int\d*\s*$'
      let v = '0'
    elseif t =~# '\v^\s*bool\s*$'
      let v = 'false'
    else
      let v = 'nil'
    endif
    call add(rets, v)
  endfor

  return '${1:' . join(rets, ", ") . '${2\}}'
endfunction
