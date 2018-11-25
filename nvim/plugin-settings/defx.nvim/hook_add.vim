" single mapping, as there's only single usage for me
" (list files in a same directory as file currently open)
nnoremap <silent> <Leader><Leader> <Cmd>Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>
