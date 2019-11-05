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

  let ret = ""
  let ma = s:find_first_line_match(re, 'up')
  if !empty(ma)
    let ret = ma[1]
  endif

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


function! g:Neosnippet_go_method_receiver() abort
  " TODO: commonize code with g:Neosnippet_go_iferr ?
  let re_func = '\vfunc'
  let re_type = '%(%([.A-Za-z0-9*]|\[|\]|%(%(struct)|%(interface)\{\}))+)'
  let re_rcvr = '\s*\((\w+\s+' . re_type . ')\)?'
  let re_name = '%(\s*\w+)?'
  let re_arg  = '\(%(\w+%(\s+%(\.\.\.)?' . re_type . ')?\s*,?\s*)*\)'

  let re_ret_v = '%(\w+)'
  let re_ret  = '%(\s*\(?(\s*\*?[a-zA-Z0-9_. ,]+)\)?\s*)?'
  let re_ret_body = '%(' . re_ret_v . '|%(' . re_ret_v  . '\s*' . re_type . ')|' . re_type . '\s*,?\s*)*'
  let re_ret  = '%(\s*\(?\s*%(' . re_ret_body . ')\)?\s*)?'
  let re = re_func . re_rcvr . re_name . re_arg . re_ret . '\{'

  let rcvr = ""
  let ma = s:find_first_line_match(re, 'up')
  if !empty(ma)
    let rcvr = ma[1]
  else
    let ma = s:find_first_line_match(re, 'down')
    if !empty(ma)
      let rcvr = ma[1]
    endif
  endif

  if rcvr =~ '\v^\s*$'
    return '${1:self} ${2:Type}'
  endif

  let rcvr_parts = split(rcvr, '\s\+')

  return '${1:' . rcvr_parts[0] . '} ${2:' . rcvr_parts[1] . '}'
endfunction


function! s:find_first_line_match(re, direction) abort
  if a:direction != 'up' && a:direction != 'down'
    throw 'direction argument should be either "up" or "down"'
  endif

  let lnum_increment = -1
  let s:condition = {lnum -> lnum > 0}
  if a:direction == 'down'
    let lnum_increment = 1
    let s:condition = {lnum -> lnum < line('$')}
  endif

  let lnum = line('.')
  let rcvr = ""
  while s:condition(lnum)
    let lnum += lnum_increment

    let ma = matchlist(getline(lnum), a:re)
    if !empty(ma)
      return ma
    endif
  endwhile

  return []
endfunction
