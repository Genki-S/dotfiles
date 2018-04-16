let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_test_timeout = "1s"
let g:go_metalinter_command = "gometalinter --enable-all ./..."

" don't let vim-go mutate neosnippet state
let g:go_snippet_engine = "none"

" K is mapped to :GoDoc by default
" Override investigate.vim mapping, since go has awesome doc tools usable
" inside Vim.
nnoremap gK :<C-u>GoInfo<CR>

command! -nargs=0 GoExport call go#rename#Rename(<bang>0, substitute(expand("<cword>"), '.*', '\u&', ''))
command! -nargs=0 GoUnexport call go#rename#Rename(<bang>0, substitute(expand("<cword>"), '.*', '\l&', ''))
