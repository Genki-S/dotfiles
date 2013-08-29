setlocal tags+=~/tags_ruby,~/tags_gem

" Indent settings
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

" Fold settings
function! RubyMethodFold(line)
	let str = getline(a:line)
	let syn_name = synIDattr(synID(a:line, 1, 0), 'name')
	if str =~ '^\s*def \w'
		return 'a1'
	elseif str =~ '^\s*end$' && syn_name == 'rubyMethodBlock'
		return 's1'
	else
		return -1
	endif
endfunction

setlocal foldmethod=expr
setlocal foldexpr=RubyMethodFold(v:lnum)

inoremap <silent> <buffer> <Leader><C-b> binding.pry
nnoremap <silent> <buffer> <Leader><C-b> mzObinding.pry<Esc>`z:delmark z<CR>
