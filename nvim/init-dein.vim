"dein Scripts-----------------------------
let s:dein_install_dir = g:nvim_config_dir . '/dein'
let s:dein_repo = s:dein_install_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_repo

" Required:
if dein#load_state(s:dein_install_dir)
  call dein#begin(s:dein_install_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo)

  call dein#load_toml(g:nvim_config_dir . '/plugins.toml', {})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

"End dein Scripts-------------------------
