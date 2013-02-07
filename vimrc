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

for f in split(glob('~/.vim/vimrc/lib/*.vim'), '\n')
	execute 'source' f
endfor

" ==================================================
" NeoBundle
" ==================================================

if strlen($http_proxy) != 0
	let g:neobundle#types#git#default_protocol = 'http'
endif
let g:plugin_setting_dir = expand('~/.vim/vimrc/plugins')
let g:plugin_interface_dir = expand('~/.vim/vimrc/plugins/interface')

" use NeoBundle
set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
	set runtimepath+=~/.vimbundles/neobundle.vim
	call neobundle#rc(expand('~/.vimbundles'))
endif

execute 'source' g:plugin_setting_dir.'/neobundle.vim.vim'

" ==================================================
" Other sources
" ==================================================
" To make the ":Man" command available
runtime ftplugin/man.vim
" Matchit.vim
runtime macros/matchit.vim

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype plugin on
filetype indent on
