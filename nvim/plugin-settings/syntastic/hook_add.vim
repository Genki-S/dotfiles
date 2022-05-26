nnoremap <Leader><CR> <Cmd>SyntasticCheck<CR>

augroup vimrc_syntastic
  autocmd!
  autocmd BufWritePost * SyntasticCheck | call s:postcheck()
augroup END

let s:ignore_list_by_filetype = {
			\ "python": [ "^Skipping analyzing " ]
			\ }

function! s:postcheck() abort
	if has_key(s:ignore_list_by_filetype, &filetype)
		call s:filter_loclist()
	endif
	call lightline#update()

	" FIXME: this doesn't focus on loc list window, but lightline thinks we are
	" focused on loc list window.
	lwindow
endfunction

function! s:filter_loclist() abort
	let filtered_loclist = []
	let ignore_list = s:ignore_list_by_filetype[&filetype]
	for locitem in getloclist(0)
		let ignore = v:false
		for ignore_pat in ignore_list
			if match(locitem["text"], ignore_pat) != -1
				let ignore = v:true
			endif
		endfor
		if !ignore
			call add(filtered_loclist, locitem)
		endif
	endfor
	call setloclist(0, filtered_loclist)
endfunction
