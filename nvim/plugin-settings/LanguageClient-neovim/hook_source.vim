nnoremap <SID>[LC] <Nop>
nmap <Leader>l <SID>[LC]

" let g:LanguageClient_loggingFile = expand('~/.tmp/vim/LanguageClient.log')
" let g:LanguageClient_loggingLevel = 'DEBUG'

" I prefer running diagnostics manually via syntastic
let g:LanguageClient_diagnosticsEnable = 0

" floating window is really not for me
let g:LanguageClient_useFloatingHover = 0

" 2 secs is the max I can wait
let g:LanguageClient_waitOutputTimeout = 2

let g:LanguageClient_serverCommands = {
      \ 'c': ['clangd'],
      \ 'cpp': ['clangd'],
      \ 'elm': ['elm-language-server', '--stdio'],
      \ 'go': ['gopls'],
      \ 'python': ['pyls'],
      \ 'javascript': ['typescript-language-server', '--stdio'],
      \ 'typescript': ['typescript-language-server', '--stdio'],
      \ 'javascriptreact': ['typescript-language-server', '--stdio'],
      \ 'typescriptreact': ['typescript-language-server', '--stdio'],
      \ 'rust': ['rust-analyzer'],
      \ 'ruby': ['solargraph', 'stdio'],
      \ 'yaml': ['yaml-language-server', '--stdio'],
      \ 'terraform': ['terraform-ls', 'serve'],
      \ }

let s:lsp_enabled_filetypes = keys(g:LanguageClient_serverCommands)

let g:LanguageClient_loadSettings = 1
let s:script_dir = resolve(expand('<sfile>:p:h'))

let g:vimrc_LangugageClient_formatOnSave = 1
function! s:lc_format() abort
  if g:vimrc_LangugageClient_formatOnSave &&
     \ (exists("b:vimrc_LangugageClient_formatOnSave") ?
     \ b:vimrc_LangugageClient_formatOnSave
     \ : v:true)
    call LanguageClient#textDocument_formatting_sync()
  endif
endfunction

" ref: https://github.com/idbrii/vim-tagimposter/commit/394d9833b21e733fff0a30b3547b61019757e074
function! s:lc_prejump() abort
  let from = [bufnr('%'), line('.'), col('.'), 0]
  let tagname = expand('<cword>')
  let stack = gettagstack()
  if stack.curidx > 1
    let stack.items = stack.items[0:stack.curidx-2]
  else
    let stack.items = []
  endif
  let stack.items += [{'from': from, 'tagname': tagname}]
  let stack.curidx = len(stack.items)
  call settagstack(win_getid(), stack)
endfunction

function s:GotoDefinitionHandler(output) abort
  " TODO: cleanup the tagstack when definition is not found
  if has_key(a:output, 'error')
    echoerr "ERROR finding definition: " . string(a:output['error'])
  elseif (has_key(a:output, 'result') && empty(a:output['result']))
    echomsg "definition not found"
  else
    " show the definition at the center of the window for easy locating &
    " consistent behavior
    normal! zz
  endif
endfunction

function! s:GotoDefinition() abort
  " https://github.com/hongyuanjia/space-vim/blob/a7f5414bb4b582609383d910fa4ed07bb3e6949e/core/autoload/spacevim/lang/util.vim#L150
  call LanguageClient#textDocument_definition({'handle': v:true}, function('s:GotoDefinitionHandler'))
endfunction

" Enables non-realtime, one-off ('ish) diagnostics
function! s:lc_toggle_diagnostics() abort
  LanguageClientStop
  let g:LanguageClient_diagnosticsEnable = 1 - g:LanguageClient_diagnosticsEnable
  " TODO: most likely, LanguageClient-neovim stores the pid of languageserver it
  " spawns. Monitor that pid rather than doing this hacky sleep.
  sleep 1
  LanguageClientStart
endfunction

function! s:lc_buffer_setup() abort
  if (!has_key(g:LanguageClient_serverCommands, &filetype))
    return
  endif

  let config_file_name = &filetype . ".json"
  let config_file_path = join([s:script_dir, "languageserver-settings", &filetype . ".json"], "/")
  " I wish this was buffer local variable
  let g:LanguageClient_settingsPath = config_file_path
  LanguageClientStart

  nnoremap <buffer> <silent> K <Cmd>call LanguageClient#textDocument_hover()<cr>
  nnoremap <buffer> <silent> <C-]> <Cmd>call <SID>lc_prejump() <Bar> call <SID>GotoDefinition()<CR>
  nnoremap <buffer> <silent> <C-w><C-]> <Cmd>split <Bar> call <SID>lc_prejump() <Bar> call <SID>GotoDefinition()<CR>
  nnoremap <buffer> <silent> <C-w><C-t><C-]> <Cmd>tabnew %:p <Bar> call <SID>lc_prejump() <Bar> call <SID>GotoDefinition()<CR>
  nnoremap <buffer> <silent> <SID>[LC]a <Cmd>call LanguageClient#textDocument_codeAction()<CR>
  nnoremap <buffer> <silent> <SID>[LC]r <Cmd>call LanguageClient#textDocument_rename()<CR>
  nnoremap <buffer> <silent> <SID>[LC]d <Cmd>call <SID>lc_toggle_diagnostics()<CR>

  autocmd BufWritePre <buffer> call <SID>lc_format()
endfunction

function! s:settagstack_curpos() abort
  let pos = getpos('.')
  let pos[0] = bufnr('%')
  let tagname = bufname('%')
  let newtag = [{'tagname': tagname, 'from': pos}]
  call settagstack(win_getid(), {'items': newtag}, 'r')
endfunction

augroup vimrc_LanguageClient-neovim
  autocmd!
  autocmd FileType * call s:lc_buffer_setup()
  autocmd FileType c let b:vimrc_LangugageClient_formatOnSave = 0
augroup END

" vim: foldmethod=marker
