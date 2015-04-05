let g:gitgutter_map_keys = 0
let g:gitgutter_escape_grep = 1
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0

" Hunk controls -- be careful not to conflict with quickhl mappings!
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk
