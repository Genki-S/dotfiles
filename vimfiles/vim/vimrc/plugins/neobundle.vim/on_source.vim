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
NeoBundle 'michaeljsmith/vim-indent-object'
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
NeoBundleLazy 'vim-scripts/UnconditionalPaste'
NeoBundle 'goldfeld/vim-seek'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-scriptease'

" Programming Features
NeoBundleLazy 'thinca/vim-quickrun'
NeoBundleLazy 'ujihisa/quicklearn'
NeoBundleLazy 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'chrisbra/changesPlugin'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'vim-scripts/IndentCommentPrefix'

" Text objects
NeoBundle "austintaylor/vim-indentobject"
NeoBundle "bootleq/vim-textobj-rubysymbol"
NeoBundle "coderifous/textobj-word-column.vim"
NeoBundle "kana/vim-textobj-datetime"
NeoBundle "kana/vim-textobj-entire"
NeoBundle "kana/vim-textobj-function"
NeoBundle "kana/vim-textobj-user"
NeoBundle "lucapette/vim-textobj-underscore"
NeoBundle "nelstrom/vim-textobj-rubyblock"
NeoBundle "thinca/vim-textobj-function-javascript"
NeoBundle "vim-scripts/argtextobj.vim"

" Integration with outer softwares / services
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv'
NeoBundleLazy 'mattn/gist-vim'
NeoBundle 'thinca/vim-ref'
NeoBundleLazy 'pydave/AsyncCommand'
NeoBundleLazy 'wannesm/wmgraphviz.vim'
NeoBundleLazy 'jpalardy/vim-slime'
NeoBundleLazy 'rking/ag.vim'
NeoBundleLazy 'lordm/vim-browser-reload-linux'
NeoBundleLazy 'sjl/clam.vim'
NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
		\ 'mac' : 'make -f make_mac.mak',
		\ 'unix' : 'make -f make_unix.mak',
	\ },
\ }
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'sjl/splice.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-scripts/TwitVim'
NeoBundle 'migemo', {'type' : 'nosync', 'base' : '~/.vim/bundles/manual'}

" For beautiful texts
NeoBundleLazy 'godlygeek/tabular'
NeoBundleLazy 'Stormherz/tablify'

" Visual
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'nathanaelkane/vim-indent-guides'

" Unite sources
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'ujihisa/unite-rake'

" Other Utilities
NeoBundleLazy 'fuenor/qfixhowm'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'fuenor/im_control.vim'
NeoBundleLazy 'gregsexton/VimCalc'
NeoBundleLazy 'vim-scripts/vimwiki'
NeoBundle 'Genki-S/vim-annotator'
NeoBundle 'hsitz/VimOrganizer'

" --------------------------------------------------
" for Specific filetypes
" --------------------------------------------------
function! s:tweak_neobundle_source_on_filetype(repo, filetypes)
	exec "NeoBundleLazy" a:repo
	exec "autocmd FileType" join(a:filetypes, ",") "MyNeoBundleSource" split(substitute(a:repo, "'", "", "g"), "/")[1]
endfunction

" Usage: NeoBundleFileType 'repo' ft1,ft2,ft3...
" Note that you cannot to use double quotes for repo
command! -nargs=+ NeoBundleFileType
	\ call s:tweak_neobundle_source_on_filetype(
		\ split("<args>", " ")[0],
		\ split(split("<args>", " ")[1], ","))

" Ruby
" --------------------------------------------------
NeoBundleFileType 'vim-ruby/vim-ruby' ruby
NeoBundleFileType 'taka84u9/vim-ref-ri' ruby
NeoBundle 'tpope/vim-rails'
NeoBundleFileType 'tpope/vim-rake' ruby
NeoBundleFileType 'tpope/vim-bundler' ruby
NeoBundleFileType 'tpope/vim-endwise' ruby,vim,sh,zsh,c,cpp
NeoBundle 'Shougo/neocomplcache-rsense'

" Markdown
" --------------------------------------------------
NeoBundle 'plasticboy/vim-markdown/'
NeoBundleFileType 'jngeist/vim-multimarkdown' mmd

" TeX
" --------------------------------------------------
NeoBundleFileType 'LaTeX-Box-Team/LaTeX-Box' tex,plaintex

" Web
" --------------------------------------------------
NeoBundleFileType 'mattn/zencoding-vim' html,xhtml,haml,php
NeoBundleFileType 'tpope/vim-haml' haml
NeoBundleFileType 'Valloric/MatchTagAlways' html,xhtml,xml,php
NeoBundleFileType 'othree/html5.vim' html,php
NeoBundleFileType 'hokaccha/vim-html5validator' html
NeoBundleFileType 'pangloss/vim-javascript' javascript
NeoBundleFileType 'hail2u/vim-css3-syntax' css,scss
NeoBundleFileType 'cakebaker/scss-syntax.vim' scss
NeoBundleFileType 'miripiruni/CSScomb-for-Vim' css,scss
NeoBundleFileType 'kchmck/vim-coffee-script' coffee

" Scala
" --------------------------------------------------
NeoBundleFileType 'derekwyatt/vim-scala' scala

" Scilab
" --------------------------------------------------
NeoBundleFileType 'vim-scripts/scilab.vim' scilab

" CSV
" --------------------------------------------------
NeoBundleFileType 'chrisbra/csv.vim' csv

" ==================================================
" Plugin settings
" ==================================================
" Policy:
"   * One setting file per one plugin
"   * Lazy load, both plugins and settings

function! g:plugin_setting_filename_on_source(plugin_name)
	return expand('~/.vim/vimrc/plugins/' . a:plugin_name . '/on_source.vim')
endfunction

function! g:plugin_setting_filename_post_source(plugin_name)
	return expand('~/.vim/vimrc/plugins/' . a:plugin_name . '/post_source.vim')
endfunction

let s:bundle_names =
	\ map(neobundle#config#get_neobundles(), 'v:val.name' )

for s:bundle_name in s:bundle_names
	let s:bundle = neobundle#get(s:bundle_name)
	function! s:bundle.hooks.on_source(bundle)
		if filereadable(g:plugin_setting_filename_on_source(a:bundle.name))
			execute 'source' g:plugin_setting_filename_on_source(a:bundle.name)
		endif
	endfunction
	function! s:bundle.hooks.post_source(bundle)
		if filereadable(g:plugin_setting_filename_post_source(a:bundle.name))
			execute 'source' g:plugin_setting_filename_post_source(a:bundle.name)
		endif
	endfunction
endfor

" --------------------------------------------------
" Helper Functions
" --------------------------------------------------
function! s:edit_plugin_setting(plugin_name)
	execute 'edit' g:plugin_setting_dir.'/'.a:plugin_name.'.vim'
endfunction

function! s:edit_plugin_interface(plugin_name)
	execute 'edit' g:plugin_interface_dir.'/'.a:plugin_name.'.vim'
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
	\ PluginInterface
	\ call s:edit_plugin_interface(<q-args>)


" ==================================================
" Installation check
" ==================================================
if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
\		string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif

