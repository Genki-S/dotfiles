setlocal tags+=~/tags_ruby,~/tags_gem

" Completion settings
NeoBundleSource neocomplete

" NOTE: disabling for now because system('vim-ruby-dictionary-path') is too slow
" TODO: get desired ruby version
" if has_key(g:neocomplete#sources#dictionary#dictionaries, 'ruby')
	" " TODO: deal with duplicates
	" let ruby_dict = g:neocomplete#sources#dictionary#dictionaries.ruby . ',' . system('vim-ruby-dictionary-path')
" else
	" let ruby_dict = system('vim-ruby-dictionary-path')
" endif
" let g:neocomplete#sources#dictionary#dictionaries.ruby = ruby_dict

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

" TODO: Make my best folding method
" setlocal foldmethod=expr
" setlocal foldexpr=RubyMethodFold(v:lnum)
setlocal foldmethod=syntax
setlocal foldlevel=1

inoremap <silent> <buffer> <Leader><C-l> <Space>=><Space>

inoremap <silent> <buffer> <Leader><C-b> require 'pry'; binding.pry
nnoremap <silent> <buffer> <Leader><C-b> mzOrequire 'pry'; binding.pry<Esc>`z:delmark z<CR>
