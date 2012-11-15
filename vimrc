" ==================================================
" My vimrc (in '~/.vim/vimrc/')
" ==================================================

" Settings
" ~/.vim/vimrc/settings.vim

" Mappings
" ~/.vim/vimrc/mappings.vim

" Commands
" ~/.vim/vimrc/commands.vim

" Visual
" ~/.vim/vimrc/visual.vim

" Sourcing them at the bottom of this file


" ==================================================
" NeoBundle
" ==================================================

if strlen($http_proxy) != 0
	let g:neobundle#types#git#default_protocol = 'http'
endif
let g:plugin_setting_dir = expand('~/.vim/vimrc/plugins')

" use NeoBundle
set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
	set runtimepath+=~/.vim/.bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/.bundle'))
endif

execute 'source' g:plugin_setting_dir.'/neobundle.vim.vim'

" ==================================================
" My vimrc sourcing
" ==================================================
for f in split(glob('~/.vim/vimrc/*.vim'), '\n')
	execute 'source' f
endfor

" ==================================================
" Other sources
" ==================================================
" To make the ":Man" command available
source /usr/share/vim/vim73/ftplugin/man.vim
" Matchit.vim
source /usr/share/vim/vim73/macros/matchit.vim

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype plugin on
filetype indent on
