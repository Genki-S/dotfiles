function! g:yaml_load(filename)
	ruby << EOF
	require 'yaml'
	obj = YAML.load_file(File.expand_path(VIM::evaluate('a:filename')))
	obj_hash = obj.inspect.gsub('=>', ':').gsub('nil', '{}')
	VIM::command("let l:ret = #{obj_hash}")
EOF
	return l:ret
endfunction

function! g:yaml_write(filename, obj)
	ruby << EOF
	require 'yaml'
	obj =  VIM::evaluate('a:obj')
	fname = File.expand_path(VIM::evaluate('a:filename'))
	File.write(File.expand_path(VIM::evaluate('a:filename')), obj.to_yaml)
EOF
endfunction

function! g:my_insert_cr_mapping()
	if neobundle#is_sourced('vim-endwise') && neobundle#is_sourced('delimitMate')
		imap <CR> <Plug>delimitMateCR<Plug>DiscretionaryEnd
	elseif neobundle#is_sourced('vim-endwise')
		imap <CR> <Plug>DiscretionaryEnd
	elseif neobundle#is_sourced('delimitMate')
		imap <CR> <Plug>delimitMateCR
	endif
endfunction

" Make it possible to issue AlterCommand before vim-altercmd is sourced
function! g:genki_altercmd(args)
	execute 'autocmd User sourced_vim-altercmd AlterCommand' a:args
endfunction

" For the sake of vim-qfreplace
function! g:genki_location_to_quickfix()
	call setqflist(getloclist(0))
	lclose
	copen
endfunction

" Set tabstop, softtabstop and shiftwidth to the same value
function! g:genki_set_taboptions()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
		" do we want expandtab as well?
		let &l:expandtab = confirm('set expandtab?', "&No\n&Yes") - 1
	endif
	call g:genki_summarize_tabs()
endfunction

function! g:genki_summarize_tabs()
	try
		echohl ModeMsg
		echon 'tabstop='.&l:ts
		echon ' shiftwidth='.&l:sw
		echon ' softtabstop='.&l:sts
		if &l:et
			echon ' expandtab'
		else
			echon ' noexpandtab'
		endif
	finally
		echohl None
	endtry
endfunction
