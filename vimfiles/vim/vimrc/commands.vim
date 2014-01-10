" This will be overwritten when vim-altercmd is sourced
command! -nargs=* AlterCommand call g:genki_altercmd(<q-args>)

command! L2Q call g:genki_location_to_quickfix()

command! Stab call g:genki_set_taboptions()

" Show all mappings
command! -nargs=* -complete=mapping AllMaps
\	map <args> | map! <args> | lmap <args>
