function! g:genki_location_to_quickfix()
	call setqflist(getloclist(0))
endfunction

" Set tabstop, softtabstop and shiftwidth to the same value
function! g:genki_set_taboptions()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
		" do we want expandtab as well?
		let &l:expandtab = confirm('set expandtab?', "&No\n&Yes") - 1
	endif
	call g:genki_summarize_tabs()
endfunction

function! g:genki_summarize_tabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction
