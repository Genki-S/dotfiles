augroup vimrc_vim-rails
	autocmd!
	autocmd User Rails call s:my_rails_settings()
augroup END

function! s:my_rails_settings()
	nnoremap <buffer> <SID>[rails] <Nop>
	nmap <buffer> <Leader>r <SID>[rails]

	nnoremap <buffer> <SID>[rails]<Space> :R 
	nnoremap <buffer> <SID>[rails]c :Rcontroller 
	nnoremap <buffer> <SID>[rails]en :Renvironment 
	nnoremap <buffer> <SID>[rails]fi :Rfixtures 
	nnoremap <buffer> <SID>[rails]fu :Rfunctionaltest 
	nnoremap <buffer> <SID>[rails]h :Rhelper 
	nnoremap <buffer> <SID>[rails]ini :Rinitializer 
	nnoremap <buffer> <SID>[rails]int :Rintegrationtest 
	nnoremap <buffer> <SID>[rails]j :Rjavascript 
	nnoremap <buffer> <SID>[rails]la :Rlayout 
	nnoremap <buffer> <SID>[rails]li :Rlib 
	nnoremap <buffer> <SID>[rails]lo :Rlocale 
	nnoremap <buffer> <SID>[rails]ma :Rmailer 
	nnoremap <buffer> <SID>[rails]mi :Rmigration 
	nnoremap <buffer> <SID>[rails]mo :Rmodel 
	nnoremap <buffer> <SID>[rails]sp :Rspec 
	nnoremap <buffer> <SID>[rails]sc :Rschema 
	nnoremap <buffer> <SID>[rails]st :Rstylesheet 
	nnoremap <buffer> <SID>[rails]t :Rtask 
	nnoremap <buffer> <SID>[rails]u :Runittest 
	nnoremap <buffer> <SID>[rails]v :Rview 

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
