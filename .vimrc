" ==================================================
" My vimrc (in '~/.vim/vimrc/')
" ==================================================

" Vim Settings
" .vim/vimrc/settings.vim

" Vim Mappings
" .vim/vimrc/mappings.vim

" Vim Syntax
" .vim/vimrc/syntax.vim

" Vim Plugin Settings
" .vim/vimrc/plugins.vim

for f in split(glob('~/.vim/vimrc/*.vim'), '\n')
	execute 'source' f
endfor


" ==================================================
" NeoBundle
" ==================================================

" use NeoBundle
set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/.bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/.bundle'))
endif

" Vim management
NeoBundle 'Shougo/neobundle.vim.git'

" Vim functions
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'YankRing.vim'

" Programming Features
NeoBundle 'SingleCompile.git'
NeoBundle 'thinca/vim-quickrun.git'
NeoBundle 'ujihisa/quicklearn.git'
NeoBundle 'gerw/vim-latex-suite.git'

" Git integration
NeoBundle 'tpope/vim-fugitive.git'

" Other Utilities
NeoBundle 'fuenor/qfixhowm.git'

filetype plugin on
filetype indent on

