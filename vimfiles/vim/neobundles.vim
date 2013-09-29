function! g:plugin_setting_dirname(plugin_name)
	return expand('~/.vim/vimrc/plugins/' . a:plugin_name)
endfunction

function! g:plugin_setting_filename(plugin_name, hook_name)
	return g:plugin_setting_dirname(a:plugin_name) . '/' . a:hook_name . '.vim'
endfunction

" ==================================================
" Bundles
" ==================================================

" Read bundle settings from yaml
ruby << EOF
	require 'yaml'
	bundles = YAML.load_file(File.expand_path('~/.vim/bundles.yml'))
	bundles_hash = bundles.inspect.gsub('=>', ':').gsub('nil', '{}')
	VIM::command("let g:my_bundles = #{bundles_hash}")
EOF

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

let s:bundle_names =
	\ map(neobundle#config#get_neobundles(), 'v:val.name' )

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

" --------------------------------------------------
" Interface
" --------------------------------------------------
command! -nargs=* -bar
	\ -complete=customlist,neobundle#complete_bundles
	\ PluginSetting
	\ call s:edit_plugin_setting(<f-args>)
" TODO: complete hook types: on_bundle, on_source, on_post_source

" ==================================================
" Installation check
" ==================================================
if neobundle#exists_not_installed_bundles()
	echomsg 'Not installed bundles : ' .
\		string(neobundle#get_not_installed_bundle_names())
	echomsg 'Please execute ":NeoBundleInstall" command.'
endif
