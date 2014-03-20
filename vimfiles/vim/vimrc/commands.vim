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
