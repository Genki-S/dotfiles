" --------------------------------------------------
" Indentation
" --------------------------------------------------
set tabstop=4
set shiftwidth=4

" --------------------------------------------------
" Folding
" --------------------------------------------------
set foldmethod=marker

" --------------------------------------------------
" Search
" --------------------------------------------------
set incsearch
set smartcase

" --------------------------------------------------
" Command Mode Options
" --------------------------------------------------
set wildmenu

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
" Undo
" --------------------------------------------------
if has('persistent_undo')
	set undodir=~/.vimundo
	set undofile
endif

" --------------------------------------------------
" Others
" --------------------------------------------------
set keywordprg=:help

" --------------------------------------------------
" For specific filetypes
" --------------------------------------------------
" CSS
autocmd FileType css,scss setlocal iskeyword+=-
