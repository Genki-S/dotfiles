" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
	\ 'python': [expand('$HOME/.anyenv/envs/pyenv/shims/pyls')],
	\ }
