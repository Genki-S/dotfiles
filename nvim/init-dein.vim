" My dein extensions

let g:dein_plugin_settings_dir = g:nvim_config_dir . '/plugin-settings'
let s:hook_names = ['hook_add', 'hook_source', 'hook_post_source']

function! s:plugin_setting_filename(plugin_name, hook_name)
  return g:dein_plugin_settings_dir . '/' . a:plugin_name . '/' . a:hook_name . '.vim'
endfunction

function! g:CompleteDeinPluginNames(arglead, cmdline, cursorpos)
  return filter(keys(g:dein#_plugins), 'stridx(tolower(v:val), tolower(a:arglead)) >= 0')
endfunction

function! s:repo_to_name(repo) abort
  return split(a:repo, '/')[1] " TODO: Is this assumption alright?
endfunction

function! s:source_hook_script(repo, hook) abort
  let f = s:plugin_setting_filename(s:repo_to_name(a:repo), a:hook)
  if filereadable(f)
    execute 'source' f
  endif
endfunction

function! g:DeinHookAdd(repo) abort
  call s:source_hook_script(a:repo, 'hook_add')
endfunction

function! g:DeinHookSource(repo) abort
  call s:source_hook_script(a:repo, 'hook_source')
endfunction

function! g:DeinHookPostSource(repo) abort
  call s:source_hook_script(a:repo, 'hook_post_source')
endfunction

function! g:DeinOpenPluginSettings(plugin_name) abort
  if a:plugin_name == ""
    throw "Plugin name is required"
  endif
  let l:settings_dir = g:dein_plugin_settings_dir . '/' . a:plugin_name
  call mkdir(l:settings_dir, 'p')
  tabnew
  arglocal
  if argc() > 0 | argdelete * | endif
  for hook_name in s:hook_names
    execute 'argadd' s:plugin_setting_filename(a:plugin_name, hook_name)
  endfor
  all
  argglobal
endfunction

command! -nargs=* -bar
  \ -complete=customlist,g:CompleteDeinPluginNames
  \ PluginSetting
  \ call g:DeinOpenPluginSettings(<q-args>)

let s:dein_install_dir = g:nvim_config_dir . '/dein'
let s:dein_repo = s:dein_install_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_repo

" Generate deinrc if necessary
let s:plugins_definition_file = g:nvim_config_dir . '/plugins.yaml'
let s:deinrc = g:nvim_config_dir . '/deinrc-generated.vim'
if getftime(s:plugins_definition_file) > getftime(s:deinrc)
  silent !generate-deinrc
  let g:dein#_base_path = s:dein_install_dir
  call dein#clear_state()
endif

" Required:
if dein#load_state(s:dein_install_dir)
  call dein#begin(s:dein_install_dir)

  " Let dein manage dein
  " Required:
  call dein#add(s:dein_repo)

  " source the generated deinrc
  execute 'source' s:deinrc

  " Required:
  call dein#end()
  call dein#save_state()
endif

" trigger source and post_source hooks manually for non-lazy plugins
call dein#call_hook('source')
autocmd VimEnter * call dein#call_hook('post_source')

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
