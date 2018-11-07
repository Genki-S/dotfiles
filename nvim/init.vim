noremap ; :
noremap : ;

let mapleader = ','

let g:nvim_config_dir = expand('$HOME/.config/nvim')

set list
set listchars=tab:>\ ,trail:_,extends:>,precedes:<,conceal:#
set tabstop=2

execute 'source ' . g:nvim_config_dir . '/init-dein.vim'
