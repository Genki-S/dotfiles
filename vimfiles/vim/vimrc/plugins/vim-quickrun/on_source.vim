" http://d.hatena.ne.jp/osyo-manga/20120919/1348054752
let g:quickrun_config = {
\   "_" : {
\       "hook/close_unite_quickfix/enable_hook_loaded" : 1,
\       "hook/unite_quickfix/enable_failure" : 1,
\       "hook/close_quickfix/enable_exit" : 1,
\       "hook/close_buffer/enable_failure" : 1,
\       "hook/close_buffer/enable_empty_data" : 1,
\       "outputter" : "multi:buffer:quickfix",
\       "hook/inu/enable" : 1,
\       "hook/inu/wait" : 20,
\       "outputter/buffer/split" : ":botright 18sp",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   }
\}
