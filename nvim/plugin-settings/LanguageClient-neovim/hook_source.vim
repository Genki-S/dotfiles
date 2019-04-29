let g:LanguageClient_serverCommands = {
	\ 'python': [expand('pyls')],
	\ }

let g:LanguageClient_diagnosticsEnable = 1
" TODO: configure this (when I become want to use it)
let g:LanguageClient_diagnosticsDisplay = {
	\ 1: {
	\ "name": "Error",
	\ "texthl": "ALEError",
	\ "signText": "E",
	\ "signTexthl": "ALEErrorSign",
	\ },
	\ 2: {
	\ "name": "Warning",
	\ "texthl": "ALEWarning",
	\ "signText": "W",
	\ "signTexthl": "ALEWarningSign",
	\ },
	\ 3: {
	\ "name": "Information",
	\ "texthl": "ALEInfo",
	\ "signText": "I",
	\ "signTexthl": "ALEInfoSign",
	\ },
	\ 4: {
	\ "name": "Hint",
	\ "texthl": "ALEInfo",
	\ "signText": "H",
	\ "signTexthl": "ALEInfoSign",
	\ },
	\}
