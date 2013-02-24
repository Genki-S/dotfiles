nnoremap <unique> <SID>[vimfiler] <Nop>
nmap <unique> <Space> <SID>[vimfiler]

nnoremap <unique> <SID>[vimfiler]<Space> :<C-u>VimFiler 
nnoremap <unique> <silent> <SID>[vimfiler]b :<C-u>VimFilerBufferDir<CR>
nnoremap <unique> <silent> <SID>[vimfiler]c :<C-u>VimFilerCurrentDir<CR>
nnoremap <unique> <silent> <SID>[vimfiler]d :<C-u>VimFilerDouble<CR>
nnoremap <unique> <silent> <SID>[vimfiler]e :<C-u>VimFilerExplorer -buffer-name=explorer -toggle<CR>
