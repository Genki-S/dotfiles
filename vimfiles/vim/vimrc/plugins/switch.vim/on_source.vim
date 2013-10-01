" Definition file: ./switch.yml
let s:switch_definitions = g:yaml_load(expand('<sfile>:p:h') . '/switch.yml')
" { 'filetype1,filetype2': [ definitions ],
"   'filetype3': [ definitions ], ... }

for [fts, defs] in items(s:switch_definitions)
	for ft in split(fts, ',')
		execute 'autocmd FileType' ft 'let b:switch_definitions = s:switch_definitions.' . ft
	endfor
endfor

doautocmd FileType
