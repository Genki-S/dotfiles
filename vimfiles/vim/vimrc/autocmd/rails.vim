" edit Gemfile in rails directory (to use vim-rails)
command! LoadGemfileInRailsDir call LoadGemfileInRailsDir()
function! LoadGemfileInRailsDir()
	if argc() == 0 && filereadable('Gemfile')
		edit Gemfile
		setfiletype ruby
	endif
endfunction

autocmd VimEnter * LoadGemfileInRailsDir
