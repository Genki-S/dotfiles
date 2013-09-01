for key in [ 'h', 'j', 'k', 'l' ]
	execute 'nnoremap ' . key . ' <Nop>'
	execute 'vnoremap ' . key . ' <Nop>'
endfor
