" proxy-editor script
" Sends buffer content to another tmux pane and clears buffer.
" Meant to be used with terminal based AI agents.

" example usage:
" $ nvim -S proxy-editor.vim -c "let g:pxe_target_pane='my-session:my-window.1'"

function! s:SendBufferToTmux()
  if !exists('g:pxe_target_pane')
    echoerr "Error: g:pxe_target_pane is not defined"
    return
  endif

  let buffer_text = join(getline(1, '$'), "\n")

  if len(buffer_text) == 0
    return
  endif

  call system("tmux load-buffer -", buffer_text)
  call system("tmux paste-buffer -d -t " . shellescape(g:pxe_target_pane))

  call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " Enter")
endfunction

function! s:SendAndClear()
  call s:SendBufferToTmux()
  %delete
endfunction

inoremap <Leader><CR> <Esc>:call <SID>SendAndClear()<CR>i
nnoremap <Leader><CR> :call <SID>SendAndClear()<CR>i
