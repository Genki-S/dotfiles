" Compiler plugin for $HOME/dotfiles/bin/gut-runner-quickfix

if exists("current_compiler")
  finish
endif
let current_compiler = "gut_runner_quickfix"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

" this format depends on $HOME/dotfiles/bin/gut_output_to_quickfix.py
" TODO: parse warning lines
CompilerSet errorformat=%f:%l:%o\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
