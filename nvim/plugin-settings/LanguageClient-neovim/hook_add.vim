" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
	\ 'python': [expand('$HOME/.anyenv/envs/pyenv/shims/pyls')],
	\ }

nnoremap <silent> K <Cmd>call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd <Cmd>call LanguageClient#textDocument_definition()<CR>
