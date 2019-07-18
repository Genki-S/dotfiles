let g:LanguageClient_settingsPath = expand('~/dotfiles/nvim/lc-settings.json')
" let g:LanguageClient_loggingFile = expand('~/.tmp/vim/LanguageClient.log')
" let g:LanguageClient_loggingLevel = 'DEBUG'

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_serverCommands = {
      \ 'elm': ['elm-language-server', '--stdio'],
      \ 'go': ['gopls'],
      \ }

let s:lsp_enabled_filetypes = keys(g:LanguageClient_serverCommands)

" Use K to show documentation in preview window {{{
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(s:lsp_enabled_filetypes, &filetype) >= 0)
    call LanguageClient#textDocument_hover()
  else
    execute 'help ' . expand('<cword>')
  endif
endfunction
" }}}

nnoremap <silent> <C-]> <Cmd>TagImposterAnticipateJump <Bar> call LanguageClient#textDocument_definition()<CR>
