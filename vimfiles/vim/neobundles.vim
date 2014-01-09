filetype off
filetype plugin indent off
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

function! s:parse_PluginSetting(qargs)
	let s:args = split(a:qargs)
	if len(s:args) == 1
		call s:edit_all_plugin_settings(s:args[0])
	elseif len(s:args) == 2
		call s:edit_plugin_setting(s:args[0], s:args[1])
	endif
endfunction
"}}}

" Manual plugins
NeoBundleLocal ~/.vim/bundles/manual

" Setup bundles {{{
let s:my_bundles = g:yaml_load('~/.vim/bundles.yml')
for bundle in s:my_bundles
	for [bundle_source_name, bundle_options] in items(bundle)
		execute 'NeoBundle "' . bundle_source_name . '"'
		let s:bundle_name = neobundle#parser#path(bundle_source_name).name
		call neobundle#config(s:bundle_name, bundle_options)
		" Original hook: on_bundle
		if filereadable(s:plugin_setting_filename(s:bundle_name, 'on_bundle'))
			execute 'source' s:plugin_setting_filename(s:bundle_name, 'on_bundle')
		endif
	endfor
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

" --------------------------------------------------
" Interface
" --------------------------------------------------
command! -nargs=* -bar
	\ -complete=customlist,neobundle#complete_bundles
	\ PluginSetting
	\ call s:parse_PluginSetting(<q-args>)
" TODO: complete hook types: on_bundle, on_source, on_post_source

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

echomsg 'Pickup: ' . s:get_random_bundle().name
"}}}
" AlterCommands {{{
AlterCommand nb Unite neobundle
AlterCommand nbi Unite -auto-quit neobundle/install
AlterCommand nbu Unite neobundle/update
AlterCommand nbc NeoBundleClean
AlterCommand nbl Unite neobundle/lazy
AlterCommand nbd NeoBundleDocs
AlterCommand nbs NeoBundleSource
"}}}

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype plugin on
filetype indent on

" vim: foldmethod=marker
