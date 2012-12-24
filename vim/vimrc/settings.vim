" --------------------------------------------------
" Indentation
" --------------------------------------------------
" default style
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

set autoindent

" --------------------------------------------------
" Folding
" --------------------------------------------------
set foldmethod=manual

" --------------------------------------------------
" Search
" --------------------------------------------------
set ignorecase
set smartcase
set incsearch
set magic

" --------------------------------------------------
" Command Mode Options
" --------------------------------------------------
set wildmenu
set wildmode=list:longest
set wildignore=*~

" --------------------------------------------------
" Motions
" --------------------------------------------------
set virtualedit=block

" --------------------------------------------------
" File manipulations
" --------------------------------------------------
set hidden
set autoread
augroup vimrc-checktime
	autocmd!
	autocmd WinEnter * checktime
augroup END

" --------------------------------------------------
" Backup
" --------------------------------------------------
set swapfile
set backup
set backupdir=~/.tmp/vim/backup

" --------------------------------------------------
" History
" --------------------------------------------------
set history=200

" --------------------------------------------------
" Undo
" --------------------------------------------------
if has('persistent_undo')
	set undodir=~/.tmp/vim/undo
	set undofile
endif

" --------------------------------------------------
" Views
" --------------------------------------------------
if has('mksession')
	set viewdir=~/.tmp/vim/view
	set viewoptions=folds,options,cursor
endif

let g:skipview_files = [
\	'[EXAMPLE PLUGIN BUFFER]'
\]
function! MakeViewCheck()
	if has('quickfix') && &buftype =~ 'nofile'
		" Buffer is marked as not a file
		return 0
	endif
	if empty(glob(expand('%:p')))
		" File does not exist on disk
		return 0
	endif
	if index(g:skipview_files, expand('%')) >= 0
		" File is in skip list
		return 0
	endif
	return 1
endfunction
augroup vimrcAutoView
    autocmd!
    " Autosave & Load Views.
    autocmd BufWritePost,BufLeave,WinLeave ?*
\		if MakeViewCheck()
\|			mkview
\|		endif
    autocmd BufWinEnter ?*
\		if MakeViewCheck()
\|			silent loadview
\|		endif
augroup end

" --------------------------------------------------
" Sessions
" --------------------------------------------------
if has('mksession')
	set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
endif

" --------------------------------------------------
" Others
" --------------------------------------------------
set encoding=utf-8
set backspace=indent,eol,start
set keywordprg=:help
set lazyredraw " for better performance

" --------------------------------------------------
" For specific filetypes
" --------------------------------------------------
" CSS
autocmd FileType css,scss setlocal iskeyword+=-
