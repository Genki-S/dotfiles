" Ignore auto closing inside string or comment
" http://secret-garden.hatenablog.com/entry/2015/05/06/211712
function! s:set_lexima(rule)
	call lexima#add_rule(a:rule)
	let ignore_rule = a:rule
	let ignore_rule.syntax = ["String", "Comment"]
	let ignore_rule.input = ignore_rule.char
	call lexima#add_rule(ignore_rule)
endfunction

call s:set_lexima({'at': '\%#',     'char': '[',    'input': '[]<Left>'})
call s:set_lexima({'at': '\%#]',    'char': '[',    'input': '['})
call s:set_lexima({'at': '\[\%#\]', 'char': ']',    'input': '<Right>'})
call s:set_lexima({'at': '\[\%#\]', 'char': '[',    'input': '[]<Left>'})
call s:set_lexima({'at': '\[\%#\]', 'char': '<BS>', 'input': '<BS><Del>'})

for [begin, end] in [['(', ')'], ['{', '}']]
	let bracket = begin.end
	call s:set_lexima({'at': '\%#',     'char': begin, 'input': bracket.'<Left>'})
	call s:set_lexima({'at': '\%#'.end, 'char': begin, 'input': begin})
	call s:set_lexima({'at': begin.'\%#'.end, 'char': end,   'input': '<Right>'})
	call s:set_lexima({'at': begin.'\%#'.end, 'char': begin, 'input': bracket.'<Left>'})
	call s:set_lexima({'at': begin.'\%#'.end, 'char': '<BS>', 'input': '<BS><Del>'})
endfor
