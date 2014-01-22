set nocompatible
if has('vim_starting')
	set runtimepath+=~/.vim/bundles/neobundle.vim
endif
call neobundle#rc(expand('~/vendor'))

NeoBundle 'Slava/testerdream', {
	\ 'build' : {
		\ 'mac' : 'ant',
		\ 'unix' : 'ant',
	\ },
\ }

NeoBundleCheck
