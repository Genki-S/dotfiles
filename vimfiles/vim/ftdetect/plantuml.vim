" autocmd BufRead,BufNewFile * :if getline(1) =~ '^.*startuml.*$'|  setlocal filetype=plantuml | endif
autocmd BufRead,BufNewFile *.pu,*.uml,*.plantuml setlocal filetype=plantuml
