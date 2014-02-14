" improved http://leafcage.hateblo.jp/entry/2013/11/23/212838
cnoreabb <silent><expr>s getcmdtype()==':' && getcmdline()=='s' ? 'OverCommandLine<CR>%s/\v' : 's'
augroup vimrc_vim-over
	autocmd!
	" delete space from abbreviation expansion
	autocmd User OverCmdLineEnter call feedkeys("\<BS>")
augroup END
