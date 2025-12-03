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
  " use random tmux buffer so that it doesn't accidentally pick up the one I use elsewhere
  let bufname = "pxe-" . system('cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 4')
  call system("tmux load-buffer -b " . bufname . " -", a:s)
  call system("tmux paste-buffer -b " . bufname . " -d -t " . shellescape(g:pxe_target_pane))
  if a:accept
    call s:SendAccept()
  endif
endfunction

function! s:SendNewline()
  if g:pxe_target_agent == "amp"
    call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " '\\' Enter")
  endif
  " fallback to Shift + Enter
  call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " \u001b\r")
endfunction

function! s:SendAccept()
  call system("tmux send-keys -t " . shellescape(g:pxe_target_pane) . " Enter")
endfunction

function! s:SendBuffer()
  let lines = getline(1, '$')
  if len(lines) == 1 && len(lines[0]) == 0
    return
  endif

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

inoremap <Leader><CR> <Esc>:call <SID>SendAndClearBuffer()<CR>i
nnoremap <Leader><CR> :call <SID>SendAndClearBuffer()<CR>i

if g:pxe_target_agent == "kilocode"
  inoremap <silent> <Leader>1 <Esc>:call <SID>SendString("/mode ask", v:true)<CR>i
  nnoremap <silent> <Leader>1 :call <SID>SendString("/mode ask", v:true)<CR>
  inoremap <silent> <Leader>2 <Esc>:call <SID>SendString("/mode code", v:true)<CR>i
  nnoremap <silent> <Leader>2 :call <SID>SendString("/mode code", v:true)<CR>
endif
