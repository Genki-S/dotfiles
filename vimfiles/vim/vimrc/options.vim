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
set breakindent
set display=lastline
set list
set listchars=tab:>\ ,trail:_,extends:>,precedes:<,conceal:#
set number
set relativenumber
"}}}
" syntax, highlighting and spelling {{{
set synmaxcol=300
set nohlsearch
set nocursorline
set colorcolumn=80,120
set conceallevel=1
set concealcursor=inc
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
set pumheight=5
set showmatch
set matchtime=1
"}}}
" tabs and indenting {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
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
set updatetime=1000
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
" using zsh for external command is too slow (because zsh my startup is slow for now...)
set shell=/bin/bash
set keywordprg=:help
" Use par to reflow text
" see: http://vimcasts.org/episodes/formatting-text-with-par/
" Using `gw` will reflow with Vim's built-in algorithm.
" stolen from https://github.com/rdlugosz/dotfiles/blob/fa77f78dab01b137ce8ec5db59c2720308c8373f/vimrc
if executable('par')
	set formatprg="par -h -w78 -B=.,\?_A_a "
endif
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
elseif $TERM ==# 'screen-256color'
	set t_Co=256
else
	set t_Co=16
endif
