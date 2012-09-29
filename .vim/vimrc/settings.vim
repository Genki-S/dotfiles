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

" --------------------------------------------------
" Command Mode Options
" --------------------------------------------------
set wildmenu
set wildmode=list:longest

" --------------------------------------------------
" Motions
" --------------------------------------------------
set virtualedit=block

" --------------------------------------------------
" File manipulations
" --------------------------------------------------
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

" --------------------------------------------------
" Undo
" --------------------------------------------------
if has('persistent_undo')
	set undodir=~/.tmp/vim/undo
	set undofile
endif

" --------------------------------------------------
" Others
" --------------------------------------------------
set encoding=utf-8
set backspace=indent,eol,start
set keywordprg=:help

" --------------------------------------------------
" For specific filetypes
" --------------------------------------------------
" CSS
autocmd FileType css,scss setlocal iskeyword+=-
