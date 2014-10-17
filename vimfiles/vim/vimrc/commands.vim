" This will be overwritten when vim-altercmd is sourced
command! -nargs=* AlterCommand call Genki_altercmd(<q-args>)

command! L2Q call Genki_location_to_quickfix()

command! Stab call Genki_set_taboptions()

command! NoTrail %s/\s\+$//

" Show all mappings
command! -nargs=* -complete=mapping AllMaps
\	map <args> | map! <args> | lmap <args>

command! -range Pbcopy <line1>,<line2>w !reattach-to-user-namespace pbcopy
command! Pbclone call system('echo ' . getreg('"') . ' | reattach-to-user-namespace pbcopy')

command! -nargs=* Google call Genki_google(<q-args>)

command! -nargs=* -bar
	\ -complete=customlist,neobundle#commands#complete_bundles
	\ PluginSetting
	\ call Genki_open_plugin_setting(<q-args>)
" TODO: complete hook types: on_bundle, on_source, on_post_source

command! -nargs=1
	\ -complete=customlist,neobundle#commands#complete_bundles
	\ ViewBundle
	\ edit $DOTDIR/vimfiles/vim/bundles/<args>
AlterCommand vb ViewBundle

command! -nargs=? Vypass call Vypass__start(<q-args>)
AlterCommand vy Vypass

command! -nargs=1 -complete=var DumpVariable call Genki_dump_variable(<q-args>)
AlterCommand dump DumpVariable

command! FollowSymlink call Genki_follow_symlink()
