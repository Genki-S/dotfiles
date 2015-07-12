let g:unite_source_tag_max_name_length = 60
let g:unite_source_tag_max_fname_length = 60

nnoremap <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
nnoremap <C-w><C-]> <C-w>s:<C-u>UniteWithCursorWord -immediately tag<CR>
