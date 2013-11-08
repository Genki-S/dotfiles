nnoremap <SID>[rails] <Nop>
nmap <Leader>r <SID>[rails]

nnoremap <SID>[rails]<Space> :R 
nnoremap <SID>[rails]c :Rcontroller 
nnoremap <SID>[rails]en :Renvironment 
nnoremap <SID>[rails]fi :Rfixtures 
nnoremap <SID>[rails]fu :Rfunctionaltest 
nnoremap <SID>[rails]h :Rhelper 
nnoremap <SID>[rails]ini :Rinitializer 
nnoremap <SID>[rails]int :Rintegrationtest 
nnoremap <SID>[rails]j :Rjavascript 
nnoremap <SID>[rails]la :Rlayout 
nnoremap <SID>[rails]li :Rlib 
nnoremap <SID>[rails]lo :Rlocale 
nnoremap <SID>[rails]ma :Rmailer 
nnoremap <SID>[rails]mi :Rmigration 
nnoremap <SID>[rails]mo :Rmodel 
nnoremap <SID>[rails]sp :Rspec 
nnoremap <SID>[rails]sc :Rschema 
nnoremap <SID>[rails]st :Rstylesheet 
nnoremap <SID>[rails]t :Rtask 
nnoremap <SID>[rails]u :Runittest 
nnoremap <SID>[rails]v :Rview 

nnoremap <SID>[rails]M :Rake 
nnoremap <SID>[rails]R :Rails 
nnoremap <SID>[rails]p :Rpp 
nnoremap <SID>[rails]g :Rgenerate 
nnoremap <SID>[rails]d :Rdestroy 

nnoremap <SID>[rails]ex :Rextract 

" For rspec-console
nnoremap <silent> <SID>[rails]r :call <SID>vimux_rspec_console()<CR>

function! s:vimux_rspec_console()
	if !exists('g:VimuxRunnerPaneIndex')
		NeoBundleSource vimux
		call VimuxRunCommand('rails c test')
	endif
	call VimuxRunCommand('rspec ' . expand('%') . ':' . line('.'))
endfunction
