let g:rspec_command = "MyRspec {spec}"

function! s:my_rspec(spec)
	" Need vim-rails
	if exists('*rails#app') && !empty(rails#app()) && rails#app().has_path('.zeus.sock') && executable('zeus')
		compiler rspec
		let save_makeprg = &makeprg
		set makeprg=zeus
		execute "Make rspec '" . a:spec . "'"
		execute "set makeprg=" . save_makeprg
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
