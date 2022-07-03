" No default mappings
let g:switch_mapping = ""

" Use double '-' for global & default switch behavior
nnoremap -- <Cmd>Switch<CR>

augroup vimrc_switch
	autocmd!
	autocmd FileType rust call s:setup_rust_mappings()
	autocmd FileType typescript call s:setup_typescript_mappings()
augroup END

function! s:setup_rust_mappings() abort
	nnoremap <buffer> -o <Cmd>call g:Switch_rust_option()<CR>
	nnoremap <buffer> -s <Cmd>call g:Switch_rust_string()<CR>
endfunction

function! s:setup_typescript_mappings() abort
	nnoremap <buffer> -p <Cmd>call g:Switch_typescript_promise()<CR>
endfunction

let s:rust_option_definitions = 
      \ [
      \   {
      \     '\(\(\k\|[<>]\)\+\)': 'Option<\1>',
      \     'Option<\(\(\k\|[<>]\)\+\)>': '\1',
      \   },
      \ ]

let s:rust_string_definitions = 
      \ [
      \   {
      \     '\("[^"]*"\)': 'String::from(\1)',
      \     'String::from(\("[^"]*"\))': '\1',
      \   },
      \ ]

let s:typescript_promise_definitions = 
      \ [
      \   {
      \     '\(\(\k\|[.<>]\)\+\)': 'Promise<\1>',
      \     'Promise<\(\(\k\|[.<>]\)\+\)>': '\1',
      \   },
      \ ]

function! g:Switch_rust_option() abort
  call switch#Switch({'definitions': s:rust_option_definitions})
endfunction

function! g:Switch_rust_string() abort
  call switch#Switch({'definitions': s:rust_string_definitions})
endfunction

function! g:Switch_typescript_promise() abort
  call switch#Switch({'definitions': s:typescript_promise_definitions})
endfunction
