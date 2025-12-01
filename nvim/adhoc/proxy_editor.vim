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

  let lines = getline(1, '$')

  if len(lines) == 1 && len(lines[0]) == 0
    return
  endif

  " use random tmux buffer so that it doesn't accidentally pick up the one I use elsewhere
  let bufname = "pxe-" . system('cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 4')

  " paste line-by-line so that AI agent can get escaped newlines
  for l in lines
    " sanitize control characters
    " (in Amp, tab triggers message navigation mode and stop accepting input as text)
    let sanitized_line = substitute(l, '\t', '\\t', 'g')
    call system("tmux load-buffer -b " . bufname . " -", sanitized_line)
    call system("tmux paste-buffer -b " . bufname . " -d -t " . shellescape(g:pxe_target_pane))
    call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " '\\' Enter")
  endfor

  call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " Enter")
endfunction

function! s:SendAndClear()
  call s:SendBufferToTmux()
  %delete
endfunction

inoremap <Leader><CR> <Esc>:call <SID>SendAndClear()<CR>i
nnoremap <Leader><CR> :call <SID>SendAndClear()<CR>i
