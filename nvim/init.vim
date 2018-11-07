noremap ; :
noremap : ;

let mapleader = ','

let g:nvim_config_dir = expand('$HOME/.config/nvim')

execute 'source ' . g:nvim_config_dir . '/init-dein.vim'
