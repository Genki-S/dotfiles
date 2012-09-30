" ==================================================
" My vimrc (in '~/.vim/vimrc/')
" ==================================================

" Settings
" .vim/vimrc/settings.vim

" Mappings
" .vim/vimrc/mappings.vim

" Commands
" .vim/vimrc/commands.vim

" Visual
" .vim/vimrc/visual.vim

" Plugin Settings
" .vim/vimrc/plugins.vim

" Sourcing them at the bottom of this file


" ==================================================
" NeoBundle
" ==================================================

"let g:neobundle_default_git_protocol = 'https'

" use NeoBundle
set nocompatible
filetype off
filetype plugin indent off

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
NeoBundle 'ujihisa/neco-look'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'sjl/gundo.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'austintaylor/vim-indentobject'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-speeddating'

" Programming Features
NeoBundle 'thinca/vim-quickrun.git'
NeoBundleLazy 'ujihisa/quicklearn.git'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'

" Integration with outer softwares / services
NeoBundle 'tpope/vim-fugitive.git'
NeoBundle 'mattn/gist-vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'pydave/AsyncCommand'
NeoBundle 'wannesm/wmgraphviz.vim'

" Visual
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'nathanaelkane/vim-indent-guides'

" Unite sources
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-help'

" Other Utilities
NeoBundleLazy 'fuenor/qfixhowm.git'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Genki-S/dry.vim'

" --------------------------------------------------
" for Specific filetypes
" --------------------------------------------------

" TeX
" --------------------------------------------------
NeoBundleLazy 'gerw/vim-latex-suite.git'

" Web
" --------------------------------------------------
NeoBundleLazy 'mattn/zencoding-vim.git'
NeoBundleLazy 'tpope/vim-haml'
NeoBundleLazy 'Valloric/MatchTagAlways'
NeoBundleLazy 'othree/html5.vim'
NeoBundleLazy 'pangloss/vim-javascript'
NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'cakebaker/scss-syntax.vim'
NeoBundle 'miripiruni/CSScomb-for-Vim'

" Sourcings
" --------------------------------------------------

" plugin - filetype dictionary
let s:plugin_filetypes = {
\	 'vim-latex-suite': [
\		'tex', 'plaintex'
\	],
\	 'zencoding-vim': [
\		'html', 'haml', 'php'
\	],
\	 'vim-haml': [
\		'haml'
\	],
\	'MatchTagAlways': [
\		'html', 'xhtml', 'xml', 'php'
\	],
\	'html5.vim': [
\		'html', 'php'
\	],
\	'vim-javascript': [
\		'js'
\	],
\	'vim-css3-syntax': [
\		'css', 'scss'
\	],
\	'scss-syntax': [
\		'scss'
\	],
\	'CSScomb-for-Vim': [
\		'css', 'scss'
\	],
\}

" helper function
function! s:source_lazy_plugin(plugin)
	try
		execute 'NeoBundleSource' a:plugin
	catch /^Vim\%((\a\+)\)\?:E127/
		" TODO: inspect what is going on about E127
	endtry
endfunction

" define sourcing autocmd
augroup sourcings
	autocmd!
augroup END
for [plugin, ftlist] in items(s:plugin_filetypes)
	augroup sourcings
		execute "autocmd FileType" join(ftlist, ',') "call s:source_lazy_plugin('".plugin."')"
	augroup END
endfor

" --------------------------------------------------
" Installation check
" --------------------------------------------------
if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
\		string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif


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
