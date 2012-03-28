set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.bundle/neobundle.vim
	call neobundle#rc(expand('~/.bundle'))
endif

" Vim functions
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'

" Web Creation
NeoBundle 'git://github.com/tpope/vim-haml.git'

" Other Utilities
NeoBundle 'git://github.com/fuenor/qfixhowm.git'

filetype plugin on
filetype indent on
