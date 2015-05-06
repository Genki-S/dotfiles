" Helper Functions {{{
let s:hook_names = ['on_bundle', 'on_source', 'on_post_source']

function! s:plugin_setting_dirname(plugin_name)
	return expand('~/.vim/vimrc/plugins/' . a:plugin_name)
endfunction

function! s:plugin_setting_filename(plugin_name, hook_name)
	return s:plugin_setting_dirname(a:plugin_name) . '/' . a:hook_name . '.vim'
endfunction

function! s:mk_plugin_setting_directory(plugin_name)
	call mkdir(s:plugin_setting_dirname(a:plugin_name))
endfunction

function! s:edit_plugin_setting(plugin_name, hook_name)
	if !isdirectory(s:plugin_setting_dirname(a:plugin_name))
		call s:mk_plugin_setting_directory(a:plugin_name)
	endif
	execute 'edit' s:plugin_setting_filename(a:plugin_name, a:hook_name)
endfunction

function! s:edit_all_plugin_settings(plugin_name)
	if !isdirectory(s:plugin_setting_dirname(a:plugin_name))
		call s:mk_plugin_setting_directory(a:plugin_name)
	endif
	tabnew
	arglocal
	if argc() > 0 | argdelete * | endif
	for hook_name in s:hook_names
		execute 'argadd' s:plugin_setting_filename(a:plugin_name, hook_name)
	endfor
	all
	argglobal
endfunction

function! Genki_open_plugin_setting(qargs)
	let s:args = split(a:qargs)
	if len(s:args) == 1
		call s:edit_all_plugin_settings(s:args[0])
	elseif len(s:args) == 2
		call s:edit_plugin_setting(s:args[0], s:args[1])
	endif
endfunction
"}}}

if strlen($http_proxy) != 0
	let g:neobundle#types#git#default_protocol = 'http'
endif

set nocompatible
if has('vim_starting')
	set runtimepath+=~/.vim/bundles/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundles'))

" Let neobundle manage neobundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Setup bundles {{{
let s:neobundlefile = expand('~/.vim/bundles.yml')
let s:neobundlefile_compiled = expand('~/.vim/neobundlefile_compiled.vim')
if getftime(s:neobundlefile) > getftime(s:neobundlefile_compiled)
	silent !compile-vimrc
	NeoBundleClearCache
	" Delete ftdetect files copied by NeoBundle (I don't need it for now)
	call neobundle#util#cleandir('ftdetect')
	call neobundle#util#cleandir('after/ftdetect')
endif

if neobundle#load_cache()
	" when cache loading fails
	execute "source" s:neobundlefile_compiled
	NeoBundleSaveCache
endif

let s:bundle_names = map(neobundle#config#get_neobundles(), 'v:val["name"]')
for bundle_name in s:bundle_names
	" Original hook: on_bundle
	if filereadable(s:plugin_setting_filename(bundle_name, 'on_bundle'))
		execute 'source' s:plugin_setting_filename(bundle_name, 'on_bundle')
	endif
endfor
"}}}

" Lazy load plugin setting files {{{
function! MyOnSourceFunction(bundle)
	if filereadable(s:plugin_setting_filename(a:bundle.name, 'on_source'))
		execute 'source' s:plugin_setting_filename(a:bundle.name, 'on_source')
	endif
endfunction

function! MyOnPostSourceFunction(bundle)
	if filereadable(s:plugin_setting_filename(a:bundle.name, 'on_post_source'))
		execute 'source' s:plugin_setting_filename(a:bundle.name, 'on_post_source')
	endif
	execute 'silent doautocmd User sourced_' . a:bundle.name
endfunction

for s:bundle in neobundle#config#get_neobundles()
	let s:bundle.hooks.on_source = function('MyOnSourceFunction')
	let s:bundle.hooks.on_post_source = function('MyOnPostSourceFunction')
endfor
"}}}

call neobundle#end()

" --------------------------------------------------
" Interface
" --------------------------------------------------
" Installation check"{{{
if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
\		string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif
"}}}
" Random reminder"{{{
function! s:get_random_bundle()
	let s:rand = system('echo $RANDOM')
	let s:all_bundles = neobundle#config#get_neobundles()
	return s:all_bundles[s:rand % len(s:all_bundles)]
endfunction

" echomsg 'Pickup: ' . s:get_random_bundle().name
"}}}
" AlterCommands {{{
AlterCommand nb Unite neobundle
AlterCommand nbi Unite -log -wrap -auto-quit neobundle/install
AlterCommand nbu Unite -log -wrap -auto-quit neobundle/update
AlterCommand nbc NeoBundleClean
AlterCommand nbl Unite neobundle/lazy
AlterCommand nbd NeoBundleDocs
AlterCommand nbs NeoBundleSource
"}}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype plugin indent on

" vim: foldmethod=marker
