nmap <C-c><C-o> <Plug>(openbrowser-smart-search)
vmap <C-c><C-o> <Plug>(openbrowser-smart-search)

autocmd BufEnter bundles.yml call s:settings_for_bundles()

function! s:settings_for_bundles()
	nmap <buffer> <C-c><C-o> ;OpenBrowser https://github.com/<C-r><C-w><CR>
endfunction
