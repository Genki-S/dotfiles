augroup vimrc_vim-rails
	autocmd!
	autocmd User Rails call s:my_rails_settings()
augroup END

function! s:my_rails_settings()
	nnoremap <buffer> <SID>[rails] <Nop>
	nmap <buffer> <Leader>r <SID>[rails]

	nnoremap <buffer> <SID>[rails]<Space> :E 
	nnoremap <buffer> <SID>[rails]c :Econtroller 
	nnoremap <buffer> <SID>[rails]en :Eenvironment 
	nnoremap <buffer> <SID>[rails]fi :Efixtures 
	nnoremap <buffer> <SID>[rails]fu :Efunctionaltest 
	nnoremap <buffer> <SID>[rails]h :Ehelper 
	nnoremap <buffer> <SID>[rails]ini :Einitializer 
	nnoremap <buffer> <SID>[rails]int :Eintegrationtest 
	nnoremap <buffer> <SID>[rails]j :Ejavascript 
	nnoremap <buffer> <SID>[rails]la :Elayout 
	nnoremap <buffer> <SID>[rails]li :Elib 
	nnoremap <buffer> <SID>[rails]lo :Elocale 
	nnoremap <buffer> <SID>[rails]ma :Emailer 
	nnoremap <buffer> <SID>[rails]mi :Emigration 
	nnoremap <buffer> <SID>[rails]mo :Emodel 
	nnoremap <buffer> <SID>[rails]sp :Espec 
	nnoremap <buffer> <SID>[rails]sc :Eschema 
	nnoremap <buffer> <SID>[rails]st :Estylesheet 
	nnoremap <buffer> <SID>[rails]t :Etask 
	nnoremap <buffer> <SID>[rails]u :Eunittest 
	nnoremap <buffer> <SID>[rails]v :Eview 

	nnoremap <buffer> <SID>[rails]M :Rake 
	nnoremap <buffer> <SID>[rails]R :Rails 
	nnoremap <buffer> <SID>[rails]p :Rpp 
	nnoremap <buffer> <SID>[rails]g :Rgenerate 
	nnoremap <buffer> <SID>[rails]d :Rdestroy 

	nnoremap <buffer> <SID>[rails]ex :Rextract 

	" For rspec-console
	nnoremap <silent> <SID>[rails]r :call <SID>vimux_rspec_console()<CR>
endfunction

function! s:vimux_rspec_console()
	if !exists('g:VimuxRunnerPaneIndex')
		NeoBundleSource vimux
		call VimuxRunCommand('rails c test')
	endif
	call VimuxRunCommand('rspec ' . expand('%') . ':' . line('.'))
endfunction
