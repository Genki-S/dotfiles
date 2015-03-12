" Definition file: ./switch.yml
let s:switch_definitions = Genki_yaml_load_with_cache(expand('<sfile>:p:h') . '/switch.yml')
" { '_': [ global definitions ],
"   'filetype1': [ definitions ],
"   'filetype2': [ definitions ], ... }

let g:switch_custom_definitions = s:switch_definitions['_']
call remove(s:switch_definitions, '_')

for ft in keys(s:switch_definitions)
	execute 'autocmd FileType' ft 'let b:switch_custom_definitions = s:switch_definitions.' . ft
endfor

doautocmd FileType
