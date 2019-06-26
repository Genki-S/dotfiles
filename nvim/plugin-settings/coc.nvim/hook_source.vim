" Use K to show documentation in preview window {{{
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'help ' . expand('<cword>')
  else
    let l:res = CocAction('doHover')
    if !l:res
      echoerr "No Documentation Found."
    endif
  endif
endfunction
" }}}

" Format certain filetypes on save {{{
command! -nargs=0 Format :call CocAction('format')
autocmd BufWritePre *.elm Format
" }}}

nnoremap <SID>[coc] <Nop>
nmap <Leader>C <SID>[coc]

" q for quickfix (though it's not actually using quickfix list)
nnoremap <SID>[coc]q <Cmd>CocList --normal --auto-preview diagnostics<CR>
" <C-]> for jump to definition (:help CTRL-])
nnoremap <C-]> <Cmd>TagImposterAnticipateJump <Bar> call CocAction("jumpDefinition")<CR>

" vim: foldmethod=marker
