noremap ; :
noremap : ;

let mapleader = ','

let g:nvim_config_dir = expand('$HOME/.config/nvim')

set list
set listchars=tab:>\ ,trail:_,extends:>,precedes:<,conceal:#
set tabstop=2

set ignorecase
set smartcase

" for padding
set signcolumn=yes

" search experience (/, ?)
" see :help 'incsearch'
set nohlsearch
augroup vimrc-incsearch-highlight
	autocmd!
	autocmd CmdlineEnter /,\? :set hlsearch
	autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Required for operations modifying multiple buffers like rename across buffers.
set hidden

" :h persistent-undo
set undofile

augroup vimrc-misc
	autocmd!
	" :h last-position-jump
	autocmd BufWinEnter *
				\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
				\ |   exe "normal! g`\""
				\ | endif
augroup END

" unimpaired-like mappings: https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim
let s:unimpaired_prev = "["
let s:unimpaired_next = "]"
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'q <Cmd>cprevious<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'q <Cmd>cnext<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'l <Cmd>lprevious<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'l <Cmd>lnext<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'od <Cmd>diffthis<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'od <Cmd>diffoff<CR>'
" the <Space> mappings doesn't preserve cursor position, but this is good enough
execute 'nnoremap <silent> ' . s:unimpaired_prev . '<Space> O<Esc>j'
execute 'nnoremap <silent> ' . s:unimpaired_next . '<Space> o<Esc>k'

" save with <C-S>
nnoremap <C-S> <Cmd>w<CR>
nnoremap <Leader><C-S> <Cmd>noautocmd w<CR>

" Run pre-commit hooks (via overcommit) and load the result to quickfix
" (requires tpope/vim-dispatch)
command! Precommit compiler pre-commit | Make

" syntax configuration
let g:go_highlight_trailing_whitespace_error = 0

execute 'source ' . g:nvim_config_dir . '/init-dein.vim'

" colorscheme
set termguicolors
colorscheme tender

let local_init = g:nvim_config_dir . '/init.local.vim'
if filereadable(local_init)
	execute 'source ' . g:nvim_config_dir . '/init.local.vim'
endif
