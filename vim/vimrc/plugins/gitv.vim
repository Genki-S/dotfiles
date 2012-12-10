" ==================================================
" Alter Commands
" ==================================================
augroup altercmd-register
	autocmd VimEnter * AlterCommand gitv SourceAndExecute gitv Gitv
augroup END
