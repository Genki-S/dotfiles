let g:rspec_command = "MyRspec {spec}"

function! s:my_rspec(spec)
	" Need vim-rails
	if exists('*rails#app') && rails#app().has_path('.zeus.sock') && executable('zeus')
		execute "Dispatch zeus rspec '" . a:spec . "'"
	else
		execute "Dispatch rspec '" . a:spec . "'"
	endif
endfunction
command! -nargs=1 MyRspec call s:my_rspec(<q-args>)

" map M beforehand to avoid E31
map M tmp
nunmap M
nnoremap Mf :call RunCurrentSpecFile()<CR>
nnoremap Mn :call RunNearestSpec()<CR>
nnoremap Ml :call RunLastSpec()<CR>
