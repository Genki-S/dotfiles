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


" unimpaired-like mappings: https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim
let s:unimpaired_prev = "["
let s:unimpaired_next = "]"
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'q <Cmd>cprevious<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'q <Cmd>cnext<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'l <Cmd>lprevious<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'l <Cmd>lnext<CR>'

execute 'source ' . g:nvim_config_dir . '/init-dein.vim'

let local_init = g:nvim_config_dir . '/init.local.vim'
if filereadable(local_init)
	execute 'source ' . g:nvim_config_dir . '/init.local.vim'
endif
