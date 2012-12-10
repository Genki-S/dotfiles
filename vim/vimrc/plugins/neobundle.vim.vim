" ==================================================
" Bundles
" ==================================================

" --------------------------------------------------
" Common
" --------------------------------------------------

" Libraries
NeoBundleLazy 'mattn/webapi-vim'

" Vim plugins management
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'MarcWeber/vim-addon-local-vimrc'

" Acceleration of Vim functionalities
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'tpope/vim-surround'
NeoBundle 'kshenoy/vim-signature'
NeoBundleLazy 'sjl/gundo.vim'
NeoBundleLazy 't9md/vim-quickhl'
NeoBundle 'austintaylor/vim-indentobject'
NeoBundle 'tpope/vim-repeat'
NeoBundleLazy 'AndrewRadev/switch.vim'
NeoBundleLazy 'vim-scripts/marvim'
NeoBundle 't9md/vim-textmanip'
NeoBundleLazy 'AndrewRadev/sideways.vim'
NeoBundleLazy 'AndrewRadev/linediff.vim'
NeoBundleLazy 'AndrewRadev/inline_edit.vim'
NeoBundleLazy 'AndrewRadev/splitjoin.vim'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'chrisbra/Recover.vim'
NeoBundle 'tyru/vim-altercmd'

" Programming Features
NeoBundleLazy 'thinca/vim-quickrun'
NeoBundleLazy 'ujihisa/quicklearn'
NeoBundleLazy 'scrooloose/syntastic'
NeoBundleLazy 'scrooloose/nerdcommenter'
NeoBundleLazy 'majutsushi/tagbar'

" Integration with outer softwares / services
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv'
NeoBundleLazy 'mattn/gist-vim'
NeoBundle 'thinca/vim-ref'
NeoBundleLazy 'pydave/AsyncCommand'
NeoBundleLazy 'wannesm/wmgraphviz.vim'
NeoBundleLazy 'jpalardy/vim-slime'
NeoBundleLazy 'mileszs/ack.vim'
NeoBundleLazy 'lordm/vim-browser-reload-linux'

" For beautiful texts
NeoBundleLazy 'godlygeek/tabular'
NeoBundleLazy 'jngeist/vim-multimarkdown'

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
NeoBundle 'fuenor/im_control.vim'
NeoBundleLazy 'gregsexton/VimCalc'

" --------------------------------------------------
" for Specific filetypes
" --------------------------------------------------

" Ruby
" --------------------------------------------------
NeoBundleLazy 'vim-ruby/vim-ruby'
NeoBundleLazy 'astashov/vim-ruby-debugger'
NeoBundleLazy 'taka84u9/vim-ref-ri'

" TeX
" --------------------------------------------------
NeoBundleLazy 'LaTeX-Box-Team/LaTeX-Box'

" Web
" --------------------------------------------------
NeoBundleLazy 'mattn/zencoding-vim'
NeoBundleLazy 'tpope/vim-haml'
NeoBundleLazy 'Valloric/MatchTagAlways'
NeoBundleLazy 'othree/html5.vim'
NeoBundleLazy 'hokaccha/vim-html5validator'
NeoBundleLazy 'pangloss/vim-javascript'
NeoBundleLazy 'hallettj/jslint.vim'
NeoBundleLazy 'hail2u/vim-css3-syntax'
NeoBundleLazy 'cakebaker/scss-syntax.vim'
NeoBundleLazy 'miripiruni/CSScomb-for-Vim'

" Scala
" --------------------------------------------------
NeoBundleLazy 'derekwyatt/vim-scala'

" Scilab
" --------------------------------------------------
NeoBundleLazy 'vim-scripts/scilab.vim'

" Sourcings
" --------------------------------------------------

" plugin - filetype dictionary
let s:plugin_filetypes = {
\	'vim-ruby': [
\		'ruby'
\	],
\	'vim-ruby-debugger': [
\		'ruby'
\	],
\	'vim-ref-ri': [
\		'ruby'
\	],
\	'LaTeX-Box': [
\		'tex', 'plaintex'
\	],
\	'zencoding-vim': [
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
\	'vim-html5validator': [
\		'html'
\	],
\	'vim-javascript': [
\		'javascript'
\	],
\	'jslint.vim': [
\		'javascript'
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
\	'vim-scala': [
\		'scala'
\	],
\	'scilab.vim': [
\		'scilab'
\	]
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
" Plugin settings
" ==================================================

" --------------------------------------------------
" Helper Functions
" --------------------------------------------------
function! s:source_plugin_setting(plugin_name)
	let l:fullpath = g:plugin_setting_dir.'/'.a:plugin_name.'.vim'
	if filereadable(l:fullpath)
		execute 'source' l:fullpath
	endif
endfunction

function! s:source_plugin_setting_after(plugin_name)
	let l:fullpath = g:plugin_setting_after_dir.'/'.a:plugin_name.'.vim'
	if filereadable(l:fullpath)
		execute 'source' l:fullpath
	endif
endfunction

function! s:edit_plugin_setting(plugin_name)
	execute 'edit' g:plugin_setting_dir.'/'.a:plugin_name.'.vim'
endfunction

function! s:edit_plugin_setting_after(plugin_name)
	execute 'edit' g:plugin_setting_after_dir.'/'.a:plugin_name.'.vim'
endfunction

function! s:source_setting_and_bundle(...)
	for bndl in a:000
		call s:source_plugin_setting(bndl)
		execute "NeoBundleSource " . bndl

		" After settings are sourced before (wired?)
		" Explanation: "After" means after sourcing AlterCommand,
		"              to provide plugins altercmds properly.
		" call s:source_plugin_setting_after(bndl)
	endfor
endfunction

function! s:register_after_plugin_settings()
	" Source 'ALL' plugins' after settings
	for plugin in s:bundle_names
		augroup vimrc_after
			execute "autocmd VimEnter * call s:source_plugin_setting_after('" . plugin . "')"
		augroup END
	endfor
endfunction

" --------------------------------------------------
" Interface
" --------------------------------------------------
command! -nargs=1 -bar
	\ -complete=customlist,neobundle#complete_bundles
	\ PluginSetting
	\ call s:edit_plugin_setting(<q-args>)

command! -nargs=1 -bar
	\ -complete=customlist,neobundle#complete_bundles
	\ PluginSettingAfter
	\ call s:edit_plugin_setting_after(<q-args>)

command! -nargs=* -bar
	\ -complete=customlist,neobundle#complete_lazy_bundles
	\ MyNeoBundleSource
	\ call s:source_setting_and_bundle(<f-args>)

" --------------------------------------------------
" Source settings
" --------------------------------------------------
let s:bundle_names =
	\ map(neobundle#config#get_neobundles(), 'v:val.name' )
let s:sourced_bundle_names =
	\ map( filter(neobundle#config#get_neobundles(),
		\ 'neobundle#config#is_sourced(v:val.name)'), 'v:val.name' )

for plugin in s:sourced_bundle_names
	if plugin !=# 'neobundle.vim'
		call s:source_plugin_setting(plugin)
	endif
endfor

augroup vimrc_after
	autocmd!
augroup END
call s:register_after_plugin_settings()
