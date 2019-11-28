" Compiler plugin for running overcommit pre-commit hook

if exists("current_compiler")
  finish
endif
let current_compiler = "pre-commit"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=.git/hooks/pre-commit

" errorformat patterns:
"   - Java Checkstyle
"   - Java PMD
"   - javac
CompilerSet errorformat=[WARN]\ %f:%l:%c:%m,[WARN]\ %f:%l:%m,%f:%l:%m,
                        \%f:%l:\ %m,
                        \%E%f:%l:\ %m,%-Z%p^,%-C%.%#,%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
