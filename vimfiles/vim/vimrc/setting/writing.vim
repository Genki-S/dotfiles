let g:neocomplcache_text_mode_filetypes = {
	\ 'text': 1,
	\ 'tex': 1,
	\ 'markdown': 1,
	\ 'mmd': 1,
	\ 'gitcommit': 1,
\ }

for ft in keys(g:neocomplcache_text_mode_filetypes)
	execute 'autocmd FileType' ft 'setlocal spell'
endfor
