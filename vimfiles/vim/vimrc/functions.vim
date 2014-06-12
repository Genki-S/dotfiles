function! Genki_yaml_load(filename)
	ruby << EOF
	require 'yaml'
	obj = YAML.load_file(File.expand_path(VIM::evaluate('a:filename')))
	obj_hash = obj.inspect.gsub('=>', ':').gsub('nil', '{}')
	VIM::command("let l:ret = #{obj_hash}")
EOF
	return l:ret
endfunction

function! Genki_yaml_write(filename, obj)
	ruby << EOF
	require 'yaml'
	obj =  VIM::evaluate('a:obj')
	fname = File.expand_path(VIM::evaluate('a:filename'))
	File.write(File.expand_path(VIM::evaluate('a:filename')), obj.to_yaml)
EOF
endfunction

function! Genki_my_insert_cr_mapping()
	if neobundle#is_sourced('vim-endwise') && neobundle#is_sourced('delimitMate')
		imap <CR> <Plug>delimitMateCR<Plug>DiscretionaryEnd
	elseif neobundle#is_sourced('vim-endwise')
		imap <CR> <Plug>DiscretionaryEnd
	elseif neobundle#is_sourced('delimitMate')
		imap <CR> <Plug>delimitMateCR
	endif
endfunction

" Make it possible to issue AlterCommand before vim-altercmd is sourced
function! Genki_altercmd(args)
	execute 'autocmd User sourced_vim-altercmd AlterCommand' a:args
endfunction

" For the sake of vim-qfreplace
function! Genki_location_to_quickfix()
	call setqflist(getloclist(0))
	lclose
	copen
endfunction

" Set tabstop, softtabstop and shiftwidth to the same value
function! Genki_set_taboptions()
	let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
	if l:tabstop > 0
		let &l:sts = l:tabstop
		let &l:ts = l:tabstop
		let &l:sw = l:tabstop
		" do we want expandtab as well?
		let &l:expandtab = confirm('set expandtab?', "&No\n&Yes") - 1
	endif
	call Genki_summarize_tabs()
endfunction

function! Genki_summarize_tabs()
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

" Quick access to Google
function! Genki_google(query)
	let l:query = a:query
	" if in vim-ref (type query again? No thanks.)
	if exists("b:ref_history")
		let l:query = b:ref_history[b:ref_history_pos][1] . " " . l:query
	endif
	call openbrowser#search(l:query)
endfunction

function! Genki_char2tmux(char)
	let keymap = {
				\ 13 : "Enter",
				\ 32 : "Space",
				\ 27 : "Escape",
				\ }
	return get(keymap, a:char, nr2char(a:char))
endfunction

function! Genki_vimux_slime_prompt(command)
	NeoBundleSource vimux
	NeoBundleSource vim-slime

	" buffer settings
	let swapfile_save = &swapfile
	set noswapfile
	edit _VimuxSlimePrompt_
	setlocal buftype=nofile
	setlocal nobuflisted
	setlocal bufhidden=delete
	setlocal nonumber
	setlocal nowrap
	let &g:swapfile = swapfile_save

	call VimuxRunCommand(a:command)

	" configure vim-slime
	let b:slime_config = {}
	let b:slime_config['socket_name'] = 'default'
	let b:slime_config['target_pane'] = ':.' . g:VimuxRunnerIndex

	" mappings
	nnoremap <buffer> <silent> <CR> :SlimeSend<CR>
	vnoremap <buffer> <silent> <CR> :SlimeSend<CR>
	inoremap <buffer> <silent> <CR> <Esc>:SlimeSend<CR>o
	nnoremap <buffer> <silent> <nowait> <Leader> :<C-u>call VimuxSendKeys(Genki_char2tmux(getchar()))<CR>
	inoremap <buffer> <silent> <expr> <nowait> <Leader> getline('.')=='' ? '<ESC>:call VimuxSendKeysWithGetcharWithCallback("startinsert")<CR>' : ','

	" Save
	let save_dir = expand('~/.vimtunnel')
	if !isdirectory(save_dir)
		call mkdir(save_dir)
	endif
	let b:save_file = save_dir . '/' . strftime('%Y-%m-%d') . '.' . getpid()
	autocmd QuitPre <buffer> execute 'write' b:save_file

	startinsert
endfunction

function! Genki_dump_variable(var_name)
	NeoBundleSource vim-prettyprint
	redir => var_content
	execute "PrettyPrint" a:var_name
	redir END
	" use split to eliminate null characters (^@) in var_content:
	" http://stackoverflow.com/questions/2573021/how-to-redirect-ex-command-output-into-current-buffer-or-file
	call append('.', split(var_content, "\n"))
endfunction
