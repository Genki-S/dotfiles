nnoremap <buffer> M :w<CR>:JUnit<CR>
nnoremap <buffer> <C-^> :<C-u>JUnitFindTest<CR>

AlterCommand eji EclimJavaImport
AlterCommand ejio EclimJavaImportOrganize

let s:java_import_auto_organize = 1

if !exists("*s:OrganizeImports()")
	function s:OrganizeImports() abort
		if s:java_import_auto_organize
			EclimJavaImportOrganize
			call system("javafmt " . expand("%:p"))
			edit
		endif
	endfunction
endif

command! JavaImportAutoOrganizeToggle let s:java_import_auto_organize = 1 - s:java_import_auto_organize

augroup vimrc_filetype-java
	autocmd!
	autocmd BufWritePre <buffer> call s:OrganizeImports()
augroup END

function! g:JavaOpenDoc() abort
	NeoBundleSource open-browser.vim
	let word = expand("<cword>")
	let lines = getline(1, "$")
	let imports = filter(lines, { i, v -> v =~# "^import" })
	let fqns = filter(imports, { i, v -> v =~# '\.' . word . ';$' })
	if empty(fqns)
		call openbrowser#search(word)
	else
		let fqn = substitute(substitute(fqns[0], '^import ', '', ''), ';$', '', '')
		if fqn =~# '^java\.'
			call openbrowser#open("https://docs.oracle.com/javase/7/docs/api/" . tr(fqn, '.', '/') . ".html")
		elseif fqn =~# '^com\.google\.protobuf'
			call openbrowser#open("https://developers.google.com/protocol-buffers/docs/reference/java/" . tr(fqn, '.', '/') . ".html")
		elseif fqn =~# '^com\.google\.'
			call openbrowser#open("https://google.github.io/guava/releases/21.0/api/docs/" . tr(fqn, '.', '/') . ".html")
		elseif fqn =~# '^com\.rabbitmq\.'
			call openbrowser#open("https://www.rabbitmq.com/releases/rabbitmq-java-client/v2.8.6/rabbitmq-java-client-javadoc-2.8.6/" . tr(fqn, '.', '/') . ".html")
		elseif fqn =~# '^org\.springframework\.'
			call openbrowser#open("http://docs.spring.io/spring-framework/docs/current/javadoc-api/" . tr(fqn, '.', '/') . ".html")
		else
			call openbrowser#search(word)
		endif
	endif
endfunction

nnoremap <buffer> K :call g:JavaOpenDoc()<CR>
