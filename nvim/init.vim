" TODO: automate virtualenv creation
let g:python3_host_prog = $PYENV_ROOT.'/versions/py3nvim/bin/python'

noremap ; :
noremap : ;

let mapleader = ','

let g:nvim_config_dir = expand('$HOME/.config/nvim')

set list
set listchars=tab:┆\ ,trail:_,extends:>,precedes:<,conceal:#
set tabstop=2

set ignorecase
set smartcase

" mostly used for viewing docs with LanguageClient-neovim
set previewheight=30

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

" prevent LanguageClient-neovim + deoplete combination from showing too-large
" preview window when selecting completion candidate
set completeopt-=preview

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
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'os <Cmd>setlocal spell<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'os <Cmd>setlocal nospell<CR>'
" the <Space> mappings doesn't preserve cursor position, but this is good enough
execute 'nnoremap <silent> ' . s:unimpaired_prev . '<Space> O<Esc>j'
execute 'nnoremap <silent> ' . s:unimpaired_next . '<Space> o<Esc>k'
" 'o' mappings are for options in official unimpaired, but this is what I like
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'oq <Cmd>copen<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'oq <Cmd>cclose<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'ol <Cmd>lopen<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'ol <Cmd>lclose<CR>'
" for plugins, probably better to map here than in plugin config file
execute 'nnoremap <silent> ' . s:unimpaired_prev . 'u <Cmd>MundoShow<CR>'
execute 'nnoremap <silent> ' . s:unimpaired_next . 'u <Cmd>MundoHide<CR>'

" save with <C-S>
nnoremap <C-S> <Cmd>w<CR>
nnoremap <Leader><C-S> <Cmd>noautocmd w<CR>
" changing tabs (I don't redraw screen with <C-L>)
nnoremap <C-H> gT
nnoremap <C-L> gt


" Run pre-commit hooks (via overcommit) and load the result to quickfix
" (requires tpope/vim-dispatch)
command! Precommit compiler pre-commit | Make

function! s:set_extra_whitespace_match(insert) abort
	let l:ignored = ["defx"]
	if index(l:ignored, &ft) != -1
		match ExtraWhitespace //
		return
	endif
	if a:insert
		match ExtraWhitespace /\s\+\%#\@<!$/
	else
		match ExtraWhitespace /\s\+$/
	endif
endfunction

" highlight trailing whitespace: https://vim.fandom.com/wiki/Highlight_unwanted_spaces
augroup vimrc-highlight-whitespace
	autocmd!
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
	autocmd BufWinEnter * call <SID>set_extra_whitespace_match(v:false)
	autocmd InsertEnter * call <SID>set_extra_whitespace_match(v:true)
	autocmd InsertLeave * call <SID>set_extra_whitespace_match(v:false)
	autocmd BufWinLeave * call clearmatches()

	" I'm not happy with this special handling but it works at least
	autocmd FileType defx call <SID>set_extra_whitespace_match(v:false)
augroup END

" dein
execute 'source ' . g:nvim_config_dir . '/init-dein.vim'

" colorscheme
set termguicolors
colorscheme tender

let local_init = g:nvim_config_dir . '/init.local.vim'
if filereadable(local_init)
	execute 'source ' . g:nvim_config_dir . '/init.local.vim'
endif
