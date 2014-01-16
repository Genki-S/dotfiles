if exists("current_compiler")
    finish
endif
let current_compiler = "rails_best_practices"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=rails_best_practices\ --without-color\ --silent
CompilerSet errorformat=%f:%l\ -\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
