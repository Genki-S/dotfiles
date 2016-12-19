set completefunc=autoprogramming#complete

function! g:Vim_auto_programming_do_completion() abort
	let ret = ""
	if strlen(getline(line('.') - 1)) > 0
		let ret = "\<C-x>\<C-u>"
	else
		let ret = ""
	endif

	return ret
endfunction

call neobundle#source('lexima.vim')
if neobundle#is_sourced('lexima.vim')
	" Execute completefunc on <CR>
	call lexima#insmode#map_hook('after', '<CR>', "\<C-r>=Vim_auto_programming_do_completion()<CR>")
end
