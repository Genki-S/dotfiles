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

function! s:start_language_client() abort
  if (!has_key(g:LanguageClient_serverCommands, &filetype))
    return
  endif

  let config_file_name = &filetype . ".json"
  let config_file_path = join([s:script_dir, "languageserver-settings", &filetype . ".json"], "/")
  " I wish this was buffer local variable
  let g:LanguageClient_settingsPath = config_file_path
  LanguageClientStart
endfunction
" }}}

" BufWritePre (formatting, organizing import, etc.) {{{
function! s:bufwritepre() abort
  " TODO: organizing import for certain filetypes
  call LanguageClient#textDocument_formatting_sync()
endfunction
" }}}

function! s:lc_maps() abort
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <silent> <C-]> <Cmd>TagImposterAnticipateJump <Bar> call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <CR> <Cmd>call LanguageClient#textDocument_codeAction()<CR>
  endif
endfunction

augroup vimrc_LanguageClient-neovim
  autocmd!
  autocmd FileType * call s:start_language_client()
  autocmd FileType * call s:lc_maps()
  autocmd BufWritePre * call s:bufwritepre()
augroup END

" vim: foldmethod=marker
