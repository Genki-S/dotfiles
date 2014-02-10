let g:rspec_command = "Dispatch rspec {spec}"

nunmap M
nnoremap Mf :call RunCurrentSpecFile()<CR>
nnoremap Mn :call RunNearestSpec()<CR>
nnoremap Ml :call RunLastSpec()<CR>
