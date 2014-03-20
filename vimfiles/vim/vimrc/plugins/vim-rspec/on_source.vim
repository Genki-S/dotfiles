let g:rspec_command = "Dispatch zeus rspec {spec}"

nunmap M
nnoremap Mf :call RunCurrentSpecFile()<CR>
nnoremap Mn :call RunNearestSpec()<CR>
nnoremap Ml :call RunLastSpec()<CR>
