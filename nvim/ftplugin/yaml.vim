" folding stolen from https://github.com/pedrohdz/vim-yaml-folds
" YamlTree stolen from https://vi.stackexchange.com/a/13519

function! YamlFolds()
  let previous_level = indent(prevnonblank(v:lnum - 1)) / &shiftwidth
  let current_level = indent(v:lnum) / &shiftwidth
  let next_level = indent(nextnonblank(v:lnum + 1)) / &shiftwidth

  if getline(v:lnum + 1) =~ '^\s*$'
    return "="

  elseif current_level < next_level
    return next_level

  elseif current_level > next_level
    return ('s' . (current_level - next_level))

  elseif current_level == previous_level
    return "="

  endif

  return next_level
endfunction

function! YamlFoldText()
  let lines = v:foldend - v:foldstart
  return getline(v:foldstart) . '   (level ' . v:foldlevel . ', lines ' . lines . ')'
endfunction

setlocal foldmethod=expr
setlocal foldexpr=YamlFolds()
setlocal foldtext=YamlFoldText()
setlocal foldlevel=9999

function! YamlTree()
    let l:list = []
    let l:cur = getcurpos()[1]
    " Retrieve the current line indentation
    let l:indent = indent(l:cur) + 1
    " Loop from the cursor position to the top of the file
    for l:n in reverse(range(1, l:cur))
        let l:i = indent(l:n)
        let l:line = getline(l:n)
        let l:key = substitute(l:line, '^\s*\(\<\w\+\>\):.*', "\\1", '')
        " If the indentation decreased and the pattern matched
        if (l:i < l:indent && l:key !=# l:line)
            let l:list = add(l:list, l:key)
            let l:indent = l:i
        endif
    endfor
    let l:list = reverse(l:list)
    echo join(l:list, ' -> ')
endfunction

nnoremap <silent><buffer> gK <Cmd>call YamlTree()<CR>

let b:undo_ftplugin =
      \ exists('b:undo_ftplugin')
      \  ? b:undo_ftplugin . ' | '
      \ : ''
      \ . 'setlocal foldexpr< foldmethod< foldtext<'
