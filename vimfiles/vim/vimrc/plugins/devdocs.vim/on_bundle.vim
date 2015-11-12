let s:devdocs_filetypes = [
\  "c",
\  "cpp",
\  "rust",
\  "haskell",
\  "python",
\  "javascript",
\]

augroup plugin-devdocs
  autocmd!
  execute 'autocmd FileType' join(s:devdocs_filetypes, ",") 'nmap <buffer> K <Plug>(devdocs-under-cursor)'
augroup END
