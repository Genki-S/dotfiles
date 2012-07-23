" ==================================================
" My vimrc (in '~/.vim/vimrc/')
" ==================================================

" Settings
" .vim/vimrc/settings.vim

" Mappings
" .vim/vimrc/mappings.vim

" Visual
" .vim/vimrc/visual.vim

" Plugin Settings
" .vim/vimrc/plugins.vim

" Sourcing them at the bottom of this file


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

" --------------------------------------------------
" Common
" --------------------------------------------------

" Libraries
NeoBundle 'mattn/webapi-vim'

" Vim plugins management
NeoBundle 'Shougo/neobundle.vim.git'

" Acceleration of Vim functionalities
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neocomplcache-snippets-complete.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'YankRing.vim'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'kshenoy/vim-signature'

" Programming Features
NeoBundle 'vim-scripts/SingleCompile.git'
NeoBundleLazy 'thinca/vim-quickrun.git'
NeoBundleLazy 'ujihisa/quicklearn.git'
NeoBundle 'scrooloose/syntastic'

" Integration with outer softwares / services
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'mattn/gist-vim'

" Visual
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-powerline'

" Other Utilities
NeoBundleLazy 'fuenor/qfixhowm.git'
NeoBundle 'h1mesuke/unite-outline'

" --------------------------------------------------
" for Specific filetypes
" --------------------------------------------------

" TeX
NeoBundleLazy 'gerw/vim-latex-suite.git'

" HTML, Haml
NeoBundleLazy 'mattn/zencoding-vim.git'

" Sourcings
autocmd FileType tex call SourceTexPlugins()
function! SourceTexPlugins()
	NeoBundleSource vim-latex-suite
endfunction

autocmd FileType html,haml call SourceWebPlugins()
function! SourceWebPlugins()
	NeoBundleSource zencoding-vim
endfunction


" ==================================================
" My vimrc sourcing
" ==================================================
for f in split(glob('~/.vim/vimrc/*.vim'), '\n')
	execute 'source' f
endfor


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype plugin on
filetype indent on
