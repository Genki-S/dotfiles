let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "x", "X"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "x", "X"]
let g:hardtime_ignore_buffer_patterns = [".*fugitive.*"]

let s:hardtime_ignore_filetypes = ["qf", "vimfiler"]

augroup vimrc_vim-hardtime
	autocmd!
	for ft in s:hardtime_ignore_filetypes
		execute "autocmd FileType" ft "HardTimeOff"
	endfor
augroup END
