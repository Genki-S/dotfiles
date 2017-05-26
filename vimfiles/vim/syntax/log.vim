" log.vim: Vim syntax file for log files (e.g. log4j logs, nginx logs, ...)
"
" This is built since I liked the idea of lnav, but couldn't actually used it
" since it doesn't have custom key bindings.

if exists("b:current_syntax")
  finish
endif

" Try to color even very long lines
set synmaxcol=0

syn case match

" https://stackoverflow.com/questions/27966587/vim-custom-highlighting-for-log-files
syn keyword levelDebug DEBUG
syn keyword levelInfo INFO
syn keyword levelWarn WARN
syn keyword levelError ERROR
hi def link levelDebug StatusLineNC
hi def link levelInfo StatusLine
hi def link levelWarn Search
hi def link levelError ErrorMsg

" https://stackoverflow.com/questions/2193157/vim-simple-steps-to-create-syntax-highlight-file-for-logfiles
syn match logDate /\d\{4}\(-\|\/\)\d\{2}\(-\|\/\)\d\{2}/ nextgroup=logTime skipwhite
syn match logTime /\d\{2}:\d\{2}:\d\{2}\(\(,\|\.\)\d\{3}\|\)/
hi def link logDate Special
hi def link logTime Identifier

syn match url /\w\+:\/\/\S*/
hi def link url Underlined

syn match filePath /\(\/\|\)\([a-zA-Z0-9.\-_%]\+\/\)\+[a-zA-Z0-9.\-_%]\+/ contains=logDate
hi def link filePath TabLine

" log4j
syn match log4jPid /\[\d\+\]/
hi def link log4jPid Constant
syn match log4jCategoryAndThread /\[[^.]\+\.[^.]\+\] \[[^]]\+\]/
hi def link log4jCategoryAndThread helpNote

" Heuristics
syn case ignore
syn keyword errorIsh error err failure failed fail couldn
hi def link errorIsh Error
syn keyword warnIsh warning warn bad
hi def link warnIsh Type
syn case match

let b:current_syntax = "log"
