filetype off
filetype plugin indent off
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:hook_names = ['on_bundle', 'on_source', 'on_post_source']

function! g:plugin_setting_dirname(plugin_name)
	return expand('~/.vim/vimrc/plugins/' . a:plugin_name)
endfunction

function! g:plugin_setting_filename(plugin_name, hook_name)
	return g:plugin_setting_dirname(a:plugin_name) . '/' . a:hook_name . '.vim'
endfunction

" ==================================================
" Bundles
" ==================================================

function! g:yaml_load(filename)
	ruby << EOF
	require 'yaml'
	obj = YAML.load_file(File.expand_path(VIM::evaluate('a:filename')))
	obj_hash = obj.inspect.gsub('=>', ':').gsub('nil', '{}')
	VIM::command("let l:ret = #{obj_hash}")
EOF
	return l:ret
endfunction

function! g:yaml_write(filename, obj)
	ruby << EOF
	require 'yaml'
	obj =  VIM::evaluate('a:obj')
	fname = File.expand_path(VIM::evaluate('a:filename'))
	File.write(File.expand_path(VIM::evaluate('a:filename')), obj.to_yaml)
EOF
endfunction

" Read bundle settings from yaml
let g:my_bundles = g:yaml_load('~/.vim/bundles.yml')

" Manual plugins
NeoBundleLocal ~/.vim/bundles/manual

for bundle in g:my_bundles
	for [bundle_source_name, bundle_options] in items(bundle)
		execute 'NeoBundle "' . bundle_source_name . '"'
		let s:bundle_name = neobundle#parser#path(bundle_source_name).name
		call neobundle#config(s:bundle_name, bundle_options)
		" Original hook: on_bundle
		if filereadable(g:plugin_setting_filename(s:bundle_name, 'on_bundle'))
			execute 'source' g:plugin_setting_filename(s:bundle_name, 'on_bundle')
		endif
	endfor
endfor

" ==================================================
" Plugin settings
" ==================================================
" Policy:
"   * One setting file per one plugin
"   * Lazy load, both plugins and settings

for s:bundle in neobundle#config#get_neobundles()
	function! s:bundle.hooks.on_source(bundle)
		if filereadable(g:plugin_setting_filename(a:bundle.name, 'on_source'))
			execute 'source' g:plugin_setting_filename(a:bundle.name, 'on_source')
		endif
	endfunction
	function! s:bundle.hooks.on_post_source(bundle)
		if filereadable(g:plugin_setting_filename(a:bundle.name, 'on_post_source'))
			execute 'source' g:plugin_setting_filename(a:bundle.name, 'on_post_source')
		endif
		execute 'silent doautocmd User sourced_' . a:bundle.name
	endfunction
endfor

" --------------------------------------------------
" Helper Functions
" --------------------------------------------------
function! s:mk_plugin_setting_directory(plugin_name)
	call mkdir(g:plugin_setting_dirname(a:plugin_name))
endfunction

function! s:edit_plugin_setting(plugin_name, hook_name)
	if !isdirectory(g:plugin_setting_dirname(a:plugin_name))
		call s:mk_plugin_setting_directory(a:plugin_name)
	endif
	execute 'edit' g:plugin_setting_filename(a:plugin_name, a:hook_name)
endfunction

function! s:edit_all_plugin_settings(plugin_name)
	if !isdirectory(g:plugin_setting_dirname(a:plugin_name))
		call s:mk_plugin_setting_directory(a:plugin_name)
	endif
	tabnew
	arglocal
	if argc() > 0 | argdelete * | endif
	for hook_name in g:hook_names
		execute 'argadd' g:plugin_setting_filename(a:plugin_name, hook_name)
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

" --------------------------------------------------
" Interface
" --------------------------------------------------
command! -nargs=* -bar
	\ -complete=customlist,neobundle#complete_bundles
	\ PluginSetting
	\ call s:parse_PluginSetting(<q-args>)
" TODO: complete hook types: on_bundle, on_source, on_post_source

" ==================================================
" Installation check
" ==================================================
if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
\		string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" ==================================================
" Random reminder
" ==================================================
function! s:get_random_bundle()
	let s:rand = system('echo $RANDOM')
	let s:all_bundles = neobundle#config#get_neobundles()
	return s:all_bundles[s:rand % len(s:all_bundles)]
endfunction

echomsg 'Pickup: ' . s:get_random_bundle().name

" ==================================================
" Call hooks
" ==================================================
if !has('vim_starting')
	call neobundle#call_hook('on_source')
	call neobundle#call_hook('on_post_source')
endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype plugin on
filetype indent on
