let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "x", "X"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "x", "X"]
let g:hardtime_ignore_buffer_patterns = [".*fugitive.*"]

let s:hardtime_ignore_filetypes = ["qf", "vimfiler"]

function! s:disable_hardtime_by_filetype()
	if index(s:hardtime_ignore_filetypes, &filetype) >= 0
		HardTimeOff
	endif
endfunction

function! s:enable_hardtime_by_filetype()
	if ! (index(s:hardtime_ignore_filetypes, &filetype) >= 0)
		HardTimeOn
	endif
endfunction

augroup vimrc_vim-hardtime
	autocmd!
	autocmd FileType,BufEnter * call s:disable_hardtime_by_filetype()
	autocmd CursorHold * silent call s:enable_hardtime_by_filetype()
augroup END
