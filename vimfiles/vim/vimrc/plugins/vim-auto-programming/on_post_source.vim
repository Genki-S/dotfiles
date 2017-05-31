set completefunc=autoprogramming#complete
call neobundle#source('lexima.vim')
if neobundle#is_sourced('lexima.vim')
	" Execute completefunc on <CR>
	call lexima#insmode#map_hook('after', '<CR>', "\<C-x>\<C-u>")
end
