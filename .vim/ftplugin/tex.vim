" --------------------------------------------------
" Text writing setting
" --------------------------------------------------
setlocal spell spelllang=en_gb
setlocal thesaurus+=~/.vim/resources/thesaurus/mthesaur.txt


" --------------------------------------------------
" Vim-LaTeX Settings
" --------------------------------------------------
filetype plugin on
set shellslash
set grepprg=grep\-nH\$*
filetype indent on
let g:Tex_CompileRule_dvi='platex $*'
let g:Tex_ViewRule_dvi='xdvi'


" --------------------------------------------------
" Helpful Functions / Mappings
" --------------------------------------------------

" Auto insertion of '\item'
function! AddItem()
	if searchpair('\\begin{itemize}', '', '\\end{itemize}', '')
		return "\\item "
	else
		return ""
	endif
endfunction
inoremap <expr><buffer> <CR> "\r".AddItem()
nnoremap <expr><buffer> o "o".AddItem()
nnoremap <expr><buffer> O "O".AddItem()

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable('Makefile')
  setlocal makeprg=make
else
  exec "setlocal makeprg=make\\ -f\\ ~/latex/latex.mk\\ " . substitute(bufname("%"),"tex$","pdf", "")
endif
