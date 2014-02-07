" This will be overwritten when vim-altercmd is sourced
command! -nargs=* AlterCommand call g:genki_altercmd(<q-args>)

command! L2Q call g:genki_location_to_quickfix()

command! Stab call g:genki_set_taboptions()

" Show all mappings
command! -nargs=* -complete=mapping AllMaps
\	map <args> | map! <args> | lmap <args>

command! -range Pbcopy <line1>,<line2>w !reattach-to-user-namespace pbcopy
command! Pbclone call system('echo ' . getreg('"') . ' | reattach-to-user-namespace pbcopy')

command! -nargs=* Google call g:genki_google(<q-args>)
