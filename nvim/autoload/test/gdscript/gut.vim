" Returns true if the given file belongs to your test runner
function! test#gdscript#gut#test_file(file) abort
  return fnamemodify(a:file, ':t') =~# 'test_.*\.gd$'
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#gdscript#gut#build_position(type, position) abort
  if a:type ==# 'suite'
    return []
  endif

  let file = fnamemodify(a:position['file'], ':t')
  return ['-gselect=' . file]
endfunction

" Returns processed args (if you need to do any processing)
function! test#gdscript#gut#build_args(args) abort
  return a:args
endfunction

" Returns the executable of your test runner
function! test#gdscript#gut#executable() abort
  return 'gut-runner-quickfix -d --path ' . getcwd() . ' -s addons/gut/gut_cmdln.gd -gdisable_colors'
endfunction
