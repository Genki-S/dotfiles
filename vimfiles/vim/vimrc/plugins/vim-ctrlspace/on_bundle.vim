let g:ctrlspace_set_default_mapping = 0
" nnoremap <silent> <C-Space> :CtrlSpace<CR>

" it seems <C-Space> sends <C-@> actually...
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim
nnoremap <silent> <C-@> :CtrlSpace<CR>
