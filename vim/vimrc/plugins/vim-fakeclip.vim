if has('mac')
	for _ in ['+', '*']
		execute 'nmap "'._.'y  <Plug>(fakeclip-y)'
		execute 'nmap "'._.'Y  <Plug>(fakeclip-Y)'
		execute 'nmap "'._.'yy  <Plug>(fakeclip-Y)'
		execute 'vmap "'._.'y  <Plug>(fakeclip-y)'
		execute 'vmap "'._.'Y  <Plug>(fakeclip-Y)'

		execute 'nmap "'._.'p  <Plug>(fakeclip-p)'
		execute 'nmap "'._.'P  <Plug>(fakeclip-P)'
		execute 'nmap "'._.'gp  <Plug>(fakeclip-gp)'
		execute 'nmap "'._.'gP  <Plug>(fakeclip-gP)'
		execute 'nmap "'._.']p  <Plug>(fakeclip-]p)'
		execute 'nmap "'._.']P  <Plug>(fakeclip-]P)'
		execute 'nmap "'._.'[p  <Plug>(fakeclip-[p)'
		execute 'nmap "'._.'[P  <Plug>(fakeclip-[P)'
		execute 'vmap "'._.'p  <Plug>(fakeclip-p)'
		execute 'vmap "'._.'P  <Plug>(fakeclip-P)'
		execute 'vmap "'._.'gp  <Plug>(fakeclip-gp)'
		execute 'vmap "'._.'gP  <Plug>(fakeclip-gP)'
		execute 'vmap "'._.']p  <Plug>(fakeclip-]p)'
		execute 'vmap "'._.']P  <Plug>(fakeclip-]P)'
		execute 'vmap "'._.'[p  <Plug>(fakeclip-[p)'
		execute 'vmap "'._.'[P  <Plug>(fakeclip-[P)'

		execute 'map! <C-r>'._.'  <Plug>(fakeclip-insert)'
		execute 'map! <C-r><C-r>'._.'  <Plug>(fakeclip-insert-r)'
		execute 'map! <C-r><C-o>'._.'  <Plug>(fakeclip-insert-o)'
		execute 'imap <C-r><C-p>'._.'  <Plug>(fakeclip-insert-p)'

		execute 'nmap "'._.'d  <Plug>(fakeclip-d)'
		execute 'vmap "'._.'d  <Plug>(fakeclip-d)'
		execute 'nmap "'._.'dd  <Plug>(fakeclip-dd)'
		execute 'nmap "'._.'D  <Plug>(fakeclip-D)'
		execute 'vmap "'._.'D  <Plug>(fakeclip-D)'
	endfor
endif
