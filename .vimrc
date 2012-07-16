" --------------------------------------------------
" NeoBundle
" --------------------------------------------------

" use NeoBundle
set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle'))
endif

" Vim management
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'

" Vim functions
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'YankRing.vim'

" Programming Features
NeoBundle 'git://github.com/vim-scripts/SingleCompile.git'
NeoBundle 'git://github.com/gerw/vim-latex-suite.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/ujihisa/quicklearn.git'

" Git integration
NeoBundle 'git://github.com/tpope/vim-fugitive.git'

" Other Utilities
NeoBundle 'git://github.com/fuenor/qfixhowm.git'

filetype plugin on
filetype indent on

" --------------------------------------------------
" My vimrc
" --------------------------------------------------

for f in split(glob('~/.vim/vimrc/*.vim'), '\n')
	execute 'source' f
endfor

" Vim Settings
" .vim/vimrc/settings.vim

" Vim Mappings
" .vim/vimrc/mappings.vim

" Vim Syntax
" .vim/vimrc/syntax.vim

" Vim Plugin Settings
" .vim/vimrc/plugins.vim

