" ==================================================
" Visual environment settings
" ==================================================
if $TERM ==# 'xterm-256color'
	set t_Co=256
else
	set t_Co=16
endif

" ==================================================
" Solarized settings
" ==================================================
syntax enable
set background=dark
colorscheme solarized


" ==================================================
" vim-indent-guides settings
" ==================================================
let g:indent_guides_enable_on_vim_startup=1


" ==================================================
" Screen Visual
" ==================================================
set scrolloff=3
set relativenumber
set cursorline
set showcmd
set noshowmode
set showmatch

set wrap
set colorcolumn=80
set textwidth=80
set formatoptions=rqnmB1

" Special Characters
set list
set listchars=tab:▸\ ,trail:_,extends:>,precedes:<


" ==================================================
" Statusline
" ==================================================
set laststatus=2


" ==================================================
" For specific filetypes
" ==================================================
autocmd BufRead,BufNewFile *.css,*.scss, setlocal foldmethod=marker foldmarker={,}
