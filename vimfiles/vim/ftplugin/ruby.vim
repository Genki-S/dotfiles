setlocal tags+=~/tags_ruby,~/tags_gem

" Indent settings
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

inoremap <silent> <buffer> <Leader><C-b> binding.pry
nnoremap <silent> <buffer> <Leader><C-b> mzObinding.pry<Esc>`z:delmark z<CR>
