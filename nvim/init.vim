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
	autocmd WinEnter * checktime
	" :h last-position-jump
	autocmd BufWinEnter *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
		\   exe "normal! g`\"" |
		\ endif
	" Auto make directories on save
	autocmd BufWritePre,FileWritePre *
		\ if !isdirectory(expand("<afile>:p:h")) |
		\   call mkdir(expand("<afile>:p:h"), "p") |
		\ endif
	" Auto chmod +x
	autocmd BufWritePost *
		\ if getline(1) =~ "^#!" && getline(1) =~ "/bin/" |
		\   execute "silent !chmod a+x" expand("<afile>:p") |
		\ endif
augroup END

" save with <C-S>
nnoremap <C-S> <Cmd>w<CR>
nnoremap <Leader><C-S> <Cmd>noautocmd w<CR>
" changing tabs (I don't redraw screen with <C-L>)
nnoremap <C-H> gT
nnoremap <C-L> gt
" copy filepath
nnoremap <silent><Leader><C-G> <Cmd>let @+ = expand('%') \| echomsg "copied filepath to clipboard: " . expand('%')<CR>


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
