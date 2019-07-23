" let g:LanguageClient_loggingFile = expand('~/.tmp/vim/LanguageClient.log')
" let g:LanguageClient_loggingLevel = 'DEBUG'

let g:LanguageClient_serverCommands = {
      \ 'elm': ['elm-language-server', '--stdio'],
      \ 'go': ['gopls'],
      \ }

let s:lsp_enabled_filetypes = keys(g:LanguageClient_serverCommands)

let g:LanguageClient_loadSettings = 1
let s:script_dir = resolve(expand('<sfile>:p:h'))

function! s:lc_buffer_setup() abort
  if (!has_key(g:LanguageClient_serverCommands, &filetype))
    return
  endif

  let config_file_name = &filetype . ".json"
  let config_file_path = join([s:script_dir, "languageserver-settings", &filetype . ".json"], "/")
  " I wish this was buffer local variable
  let g:LanguageClient_settingsPath = config_file_path
  LanguageClientStart

  nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
  nnoremap <buffer> <silent> <C-]> <Cmd>TagImposterAnticipateJump <Bar> call LanguageClient#textDocument_definition()<CR>
  nnoremap <buffer> <silent> <CR> <Cmd>call LanguageClient#textDocument_codeAction()<CR>

  autocmd BufWritePre <buffer> call LanguageClient#textDocument_formatting_sync()
endfunction

augroup vimrc_LanguageClient-neovim
  autocmd!
  autocmd FileType * call s:lc_buffer_setup()
augroup END

" vim: foldmethod=marker
