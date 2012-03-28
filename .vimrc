set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.bundle/neobundle.vim
	call neobundle#rc(expand('~/.bundle'))
endif

NeoBundle 'git://github.com/Shougo/neobundle.vim.git'

filetype plugin on
filetype indent on
