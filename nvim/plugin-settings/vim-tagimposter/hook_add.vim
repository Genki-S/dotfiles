augroup vimrc_vim-tagimposter
	autocmd!
	" Setting up tagimposter on VimEnter so that other plugins using &tags would
	" work nicely. For example, projectionist.vim copies &tags to &l:tags, so I
	" need tagimposter setting to be present in &tags before projectionist.vim
	" is invoked.
	autocmd VimEnter * call tagimposter#setup()
augroup END
