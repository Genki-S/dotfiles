nmap <Leader><C-x><C-o> <Plug>(openbrowser-smart-search)
vmap <Leader><C-x><C-o> <Plug>(openbrowser-smart-search)

autocmd BufEnter bundles.yml call s:settings_for_bundles()

function! s:settings_for_bundles()
	nmap <buffer> <Leader><C-x><C-o> ;OpenBrowser https://github.com/<C-r><C-w><CR>
endfunction
