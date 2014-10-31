nnoremap <SID>[fugitive] <Nop>
nmap <Leader>g <SID>[fugitive]
nnoremap <SID>[fugitive]<Space> :Git 
nnoremap <SID>[fugitive]s :Gstatus<CR>
nnoremap <SID>[fugitive]c :Gcommit<CR>
nnoremap <SID>[fugitive]C :Git commit --amend<CR>
nnoremap <SID>[fugitive]g :Ggrep 
nnoremap <SID>[fugitive]l :Glog 
nnoremap <SID>[fugitive]e :Gedit 
nnoremap <SID>[fugitive]v :Gvsplit 
nnoremap <SID>[fugitive]t :Gtabedit 
nnoremap <SID>[fugitive]re :Gread<CR>
nnoremap <SID>[fugitive]w :Gwrite<CR>
nnoremap <SID>[fugitive]d :Gdiff 
nnoremap <SID>[fugitive]mv :Gmove 
nnoremap <SID>[fugitive]rm :Gremove<CR>
nnoremap <SID>[fugitive]b :Gblame<CR>
nnoremap <SID>[fugitive]ms :call Genki_echo_commit_message()<CR>

augroup vimrc_vim-figitive
	autocmd!
	" Because my vim lose .git/tags on occasion...
	autocmd BufEnter * call fugitive#detect(expand('<amatch>:p'))
augroup END

function! Genki_echo_commit_message()
	let dir = getcwd()
	try
		execute 'lcd' fugitive#extract_git_dir('%')
		let s:commit_message = system('git log --format=format:"%s (%ad %an)" --date=short -n1 ' . fugitive#buffer().commit())
		echo split(s:commit_message, "\n")[0]
	catch
	finally
		execute 'lcd' dir
	endtry
endfunction

function! Fugitive_open_pull_request()
	let buf = fugitive#buffer()
	if buf.type() ==# 'commit'
		let rev = fugitive#buffer().rev()
	else
		" maybe in blame mode
		let rev = matchstr(getline('.'),'\x\+')
	endif
	let revision_minimum_required_chars = 6
	if strchars(rev) < revision_minimum_required_chars
		echoerr 'Use this in either blame or commit view'
		return
	endif
	call system('git prbrowse ' . rev . ' &') " run in background because it can be slow
	echo 'Opening pull request...'
endfunction
command! Gprbrowse call Fugitive_open_pull_request()
