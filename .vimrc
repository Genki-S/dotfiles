" Vim Settings
" .bundle/vimrc/plugin/settings.vim
"
" Vim Mappings
" .bundle/vimrc/plugin/mappings.vim
"
" Vim Syntax
" .bundle/vimrc/plugin/syntax.vim
"
" Vim Plugin Settings
" .bundle/vimrc/plugin/plugins.vim


" use NeoBundle
set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.bundle/neobundle.vim
	call neobundle#rc(expand('~/.bundle'))
endif


" Vim management
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'

" Vim functions
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'

" Programming Features
NeoBundle 'git://github.com/vim-scripts/SingleCompile.git'
NeoBundle 'git://github.com/gerw/vim-latex-suite.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/ujihisa/quicklearn.git'

" Git integration
NeoBundle 'git://github.com/vim-scripts/vcscommand.vim.git'

" Web Creation
NeoBundle 'git://github.com/tpope/vim-haml.git'

" Other Utilities
NeoBundle 'git://github.com/fuenor/qfixhowm.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'

" my vimrc
NeoBundle 'vimrc'

filetype plugin on
filetype indent on
