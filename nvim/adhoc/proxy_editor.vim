" proxy-editor script
" Sends buffer content to another tmux pane and clears buffer.
" Meant to be used with terminal based AI agents.

" example usage:
" $ nvim -S proxy-editor.vim -c "let g:pxe_target_pane='my-session:my-window.1'"

if !exists('g:pxe_target_pane')
  echoerr "Error: g:pxe_target_pane should be defined before sourcing this script"
  finish
endif

if !exists('g:pxe_target_agent')
  echoerr "Error: g:pxe_target_agent should be defined before sourcing this script"
  finish
endif

function! s:SendString(s, accept)
  let s = a:s
  " use random tmux buffer so that it doesn't accidentally pick up the one I use elsewhere
  let bufname = "pxe-" . system('cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 4')
  call system("tmux load-buffer -b " . bufname . " -", s)
  call system("tmux paste-buffer -b " . bufname . " -d -t " . shellescape(g:pxe_target_pane))
  if a:accept
    call s:SendAccept()
  endif
endfunction

function! s:SendNewline()
  if g:pxe_target_agent == "amp"
    call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " '\\' Enter")
    return
  endif
  " fallback to Shift + Enter
  call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " \u001b\r")
endfunction

function! s:SendAccept()
  sleep 200m
  call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " Enter")
endfunction

function! s:RecordPrompt(lines)
  let state_home = empty($XDG_STATE_HOME) ? expand('~/.local/state') : expand($XDG_STATE_HOME)
  let history_dir = state_home . '/ai-proxy-editor'
  let history_file = history_dir . '/history.yaml'
  let timestamp = strftime('%Y-%m-%dT%H:%M:%S%z')
  let timestamp = substitute(timestamp, '\([+-]\d\d\)\(\d\d\)$', '\1:\2', '')
  let entry = [
        \ '---',
        \ 'timestamp: ' . json_encode(timestamp),
        \ 'cwd: ' . json_encode(getcwd()),
        \ 'agent: ' . json_encode(g:pxe_target_agent),
        \ 'prompt: |-',
        \ ]
  call extend(entry, map(copy(a:lines), '"  " . v:val'))

  try
    call mkdir(history_dir, 'p', 0700)
    call writefile([], history_file, 'a')
    call setfperm(history_file, 'rw-------')
    call system(['flock', history_file . '.lock', 'tee', '-a', history_file], join(entry, "\n") . "\n")
    if v:shell_error
      throw 'flock exited with status ' . v:shell_error
    endif
  catch
    echohl ErrorMsg
    echomsg 'Failed to record prompt history in ' . history_file . ': ' . v:exception
    echohl None
  endtry
endfunction

function! s:SendBuffer()
  let lines = getline(1, '$')
  if len(lines) == 1 && len(lines[0]) == 0
    return
  endif

  call s:RecordPrompt(lines)

  " paste line-by-line so that AI agent can get escaped newlines
  for l in lines
    " sanitize control characters
    " (in Amp, tab triggers message navigation mode and stop accepting input as text)
    " TODO: customize sanitization based on target agent
    let sanitized_line = substitute(l, '\t', '\\t', 'g')
    call s:SendString(sanitized_line, v:false)
    call s:SendNewline()
  endfor

  call s:SendAccept()
endfunction

function! s:SendAndClearBuffer()
  call s:SendBuffer()
  %delete
endfunction

inoremap <Leader><CR> <C-G>u<Esc>:call <SID>SendAndClearBuffer()<CR>i
nnoremap <Leader><CR> :call <SID>SendAndClearBuffer()<CR>i

if g:pxe_target_agent == "kilocode"
  inoremap <silent> <Leader>1 <Esc>:call <SID>SendString("/mode ask", v:true)<CR>i
  nnoremap <silent> <Leader>1 :call <SID>SendString("/mode ask", v:true)<CR>
  inoremap <silent> <Leader>2 <Esc>:call <SID>SendString("/mode code", v:true)<CR>i
  nnoremap <silent> <Leader>2 :call <SID>SendString("/mode code", v:true)<CR>
endif
