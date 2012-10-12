" ==================================================
" Bundles
" ==================================================

" --------------------------------------------------
" Common
" --------------------------------------------------

" Libraries
NeoBundle 'mattn/webapi-vim'

" Vim plugins management
NeoBundle 'Shougo/neobundle.vim'

" Acceleration of Vim functionalities
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'sjl/gundo.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'austintaylor/vim-indentobject'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-speeddating'

" Programming Features
NeoBundle 'thinca/vim-quickrun'
NeoBundleLazy 'ujihisa/quicklearn'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'

" Integration with outer softwares / services
NeoBundle 'tpope/vim-fugitive'
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
NeoBundleLazy 'fuenor/qfixhowm'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Genki-S/dry.vim'

" --------------------------------------------------
" for Specific filetypes
" --------------------------------------------------

" TeX
" --------------------------------------------------
NeoBundleLazy 'gerw/vim-latex-suite'

" Web
" --------------------------------------------------
NeoBundleLazy 'mattn/zencoding-vim'
NeoBundleLazy 'tpope/vim-haml'
NeoBundleLazy 'Valloric/MatchTagAlways'
NeoBundleLazy 'othree/html5.vim'
NeoBundleLazy 'pangloss/vim-javascript'
NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'cakebaker/scss-syntax.vim'
NeoBundleLazy 'miripiruni/CSScomb-for-Vim'

" Sourcings
" --------------------------------------------------

" plugin - filetype dictionary
let s:plugin_filetypes = {
\	 'vim-latex-suite': [
\		'tex', 'plaintex'
\	],
\	 'zencoding-vim': [
\		'html', 'xhtml', 'haml', 'php'
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
" Interface
" ==================================================
command! -nargs=1 -bar
	\ -complete=customlist,neobundle#complete_bundles
	\ PluginSetting
	\ call s:edit_plugin_setting(<q-args>)

" ==================================================
" Helper Functions
" ==================================================
let s:plugin_names = map(neobundle#config#get_neobundles(), 'v:val.name')

function! s:source_plugin_setting(plugin_name)
	let l:fullpath = g:plugin_setting_dir.'/'.a:plugin_name.'.vim'
	if filereadable(l:fullpath)
		execute 'source' l:fullpath
	endif
endfunction

function! s:source_all_plugin_settings()
	for plugin in s:plugin_names
		if plugin !=# 'neobundle.vim'
			call s:source_plugin_setting(plugin)
		endif
	endfor
endfunction

function! s:edit_plugin_setting(plugin_name)
	execute 'edit' g:plugin_setting_dir.'/'.a:plugin_name.'.vim'
endfunction

" Initialization
call s:source_all_plugin_settings() " I know this is not cool
" TODO: souce settings for lazy plugins when those are sourced (need to hook NeoBundleSource command?)
