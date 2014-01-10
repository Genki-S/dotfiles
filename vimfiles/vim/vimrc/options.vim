" Categories are found by :options
" important {{{
"}}}
" moving around, searching and patterns {{{
set incsearch
set magic
set ignorecase
set smartcase
"}}}
" tags {{{
"}}}
" displaying text {{{
set scrolloff=3
set wrap
set list
set listchars=tab:>\ ,trail:_,extends:>,precedes:<
set relativenumber
"}}}
" syntax, highlighting and spelling {{{
set nohlsearch
set cursorline
set colorcolumn=80
"}}}
" multiple windows {{{
set laststatus=2
set hidden
"}}}
" multiple tab pages {{{
"}}}
" terminal {{{
"}}}
" using the mouse {{{
"}}}
" printing {{{
"}}}
" messages and info {{{
set showcmd
set noshowmode
"}}}
" selecting text {{{
"}}}
" editing text {{{
set backspace=indent,eol,start
set formatoptions=rqnmB1
set showmatch
"}}}
" tabs and indenting {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
"}}}
" folding {{{
set foldmethod=marker
"}}}
" diff mode {{{
"}}}
" mapping {{{
"}}}
" reading and writing files {{{
set backup
set backupdir=~/.tmp/vim/backup
set autoread
" Vim builtin encryption (http://usevim.com/2013/11/01/vim-encryption/)
set cryptmethod=blowfish
"}}}
" the swap file {{{
set swapfile
"}}}
" command line editing {{{
set history=200
set wildmode=list:longest
set wildignore+=*~,*.obj
if has('persistent_undo')
	set undodir=~/.tmp/vim/undo
	set undofile
endif
"}}}
" executing external commands {{{
set keywordprg=:help
"}}}
" multi-byte characters {{{
set encoding=utf-8
"}}}
" various {{{
set virtualedit=block
if has('mksession')
	set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize
	set viewdir=~/.tmp/vim/view
	set viewoptions=cursor,folds
endif
"}}}
if $TERM ==# 'xterm-256color'
	set t_Co=256
else
	set t_Co=16
endif
