let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_test_timeout = "1s"
let g:go_metalinter_command = "gometalinter --enable-all ./..."

" K is mapped to :GoDoc by default
" Override investigate.vim mapping, since go has awesome doc tools usable
" inside Vim.
nnoremap <buffer> gK :<C-u>GoInfo<CR>
