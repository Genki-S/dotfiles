nnoremap <unique> <SID>[vimwiki] <Nop>
nmap <unique> <Leader>w <SID>[vimwiki]

nnoremap <SID>[vimwiki]w :MyNeoBundleSource vimwiki<CR>:VimwikiIndex<CR>
nnoremap <SID>[vimwiki]t :MyNeoBundleSource vimwiki<CR>:VimwikiTabIndex<CR>
nnoremap <SID>[vimwiki]s :MyNeoBundleSource vimwiki<CR>:VimwikiUISelect<CR>
nnoremap <SID>[vimwiki]d :MyNeoBundleSource vimwiki<CR>:VimwikiDiaryIndex<CR>
