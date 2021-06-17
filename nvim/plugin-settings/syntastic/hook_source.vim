let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': []
      \}

let g:syntastic_typescript_checkers = ["eslint"]
let g:syntastic_typescriptreact_checkers = ["typescript/eslint"]
let g:syntastic_yaml_checkers = ["yamllint"]
