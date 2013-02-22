setlocal tags+=~/tags_ruby,~/tags_gem

" Indent settings
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

inoremap <buffer> <Leader><C-b> require "pry"; binding.pry
nnoremap <buffer> <Leader><C-b> orequire "pry"; binding.pry<Esc>
