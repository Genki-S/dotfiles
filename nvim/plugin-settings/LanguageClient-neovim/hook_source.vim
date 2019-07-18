" let g:LanguageClient_loggingFile = expand('~/.tmp/vim/LanguageClient.log')
" let g:LanguageClient_loggingLevel = 'DEBUG'

let g:LanguageClient_serverCommands = {
      \ 'elm': ['elm-language-server', '--stdio'],
      \ 'go': ['gopls'],
      \ }

let s:lsp_enabled_filetypes = keys(g:LanguageClient_serverCommands)

" Starting LanguageClient {{{
let g:LanguageClient_loadSettings = 1
let s:script_dir = resolve(expand('<sfile>:p:h'))

function! s:start_language_client(ft) abort
  if (index(s:lsp_enabled_filetypes, &filetype) < 0)
    return
  endif

  let config_file_name = a:ft . ".json"
  let config_file_path = join([s:script_dir, "languageserver-settings", a:ft . ".json"], "/")
  " I wish this was buffer local variable
  let g:LanguageClient_settingsPath = config_file_path
  LanguageClientStart
endfunction

augroup vimrc_LanguageClient-neovim
  autocmd!
  autocmd FileType * call s:start_language_client(&ft)
augroup END
" }}}

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

" vim: foldmethod=marker
