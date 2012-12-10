" ==================================================
" Alter Commands
" ==================================================
augroup altercmd-register
	autocmd VimEnter * AlterCommand gundo SourceAndExecute gundo.vim GundoToggle
augroup END
