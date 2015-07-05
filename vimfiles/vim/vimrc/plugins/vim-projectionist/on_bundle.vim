if findfile(".projections.json", ".;") != ""
	if neobundle#tap("vim-projectionist")
		call neobundle#config( { "lazy" : 0 } )
		call neobundle#untap()
	end
endif
