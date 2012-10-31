if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	autocmd! BufRead,BufNewFile *.scala setfiletype scala
augroup END
