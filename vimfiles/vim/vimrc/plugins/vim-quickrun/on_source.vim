" http://d.hatena.ne.jp/osyo-manga/20120919/1348054752
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "multi:buffer:quickfix",
\       "hook/inu/enable" : 1,
\       "hook/inu/wait" : 20,
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   },
\   "javascript" : {
\       "type" : "javascript/nodejs",
\   },
\   "swift" : {
\       "command" : "xcrun",
\       "cmdopt" : "swift",
\       "exec" : "%c %o %s",
\   },
\   "plantuml" : {
\       "command" : "plantuml",
\       "exec" : ["%c %s", "open %s:p:r.png"],
\       "outputter" : "null",
\   }
\}
