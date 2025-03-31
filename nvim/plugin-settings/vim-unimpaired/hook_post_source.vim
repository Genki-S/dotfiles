let s:unimpaired_prev = "["
let s:unimpaired_next = "]"
" 'o' mappings are for options in official unimpaired, but this is what I like
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'oq <Cmd>copen<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'oq <Cmd>cclose<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'ol <Cmd>lopen<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'ol <Cmd>lclose<CR>'
" for plugins, probably better to map here than in plugin config file
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'u <Cmd>MundoShow<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'u <Cmd>MundoHide<CR>'

