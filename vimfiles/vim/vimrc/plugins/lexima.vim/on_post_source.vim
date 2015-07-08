" Ignore auto closing inside string or comment
" http://secret-garden.hatenablog.com/entry/2015/05/06/211712
function! s:set_ignore(rule)
	let ignore_rule = a:rule
	let ignore_rule.syntax = ['String', 'Comment']
	let ignore_rule.input = ignore_rule.char
	call lexima#add_rule(ignore_rule)
endfunction

call s:set_ignore({'at': '\%#', 'char': '['})
call s:set_ignore({'at': '\%#', 'char': ']'})

for [begin, end] in [['(', ')'], ['{', '}']]
	let bracket = begin.end
	call s:set_ignore({'at': '\%#', 'char': begin})
	call s:set_ignore({'at': '\%#', 'char': end})
endfor
