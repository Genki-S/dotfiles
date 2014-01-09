let g:watchdogs_check_BufWritePost_enable = 1

if !neobundle#is_sourced('vim-quickrun')
	NeoBundleSource vim-quickrun
endif

call watchdogs#setup(g:quickrun_config)
