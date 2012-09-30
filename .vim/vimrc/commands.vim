" Show all mappings
command!
\	-nargs=* -complete=mapping
\	AllMaps
\	map <args> | map! <args> | lmap <args>

" Open junk file
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
	let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
	if !isdirectory(l:junk_dir)
		call mkdir(l:junk_dir, 'p')
	endif

	let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
	if l:filename != ''
		execute 'edit ' . l:filename
	endif
endfunction

" load quickfix filenames into args
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
" populate the argument list with each of the files named in the quickfix list
function! QuickfixFilenames()
	let buffer_numbers = {}
	for quickfix_item in getqflist()
		let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
	endfor
	return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
