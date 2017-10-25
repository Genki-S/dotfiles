" Override some mappings

" Quickfix/Location windows
nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap [ol :lopen<CR>
nnoremap ]ol :lclose<CR>

silent execute "nmap [U" maparg("[u", "n")
silent execute "xmap [U" maparg("[u", "x")
silent execute "nmap [UU" maparg("[uu", "n")
silent execute "xmap [UU" maparg("[uu", "x")
silent execute "nmap ]U" maparg("]u", "n")
silent execute "xmap ]U" maparg("]u", "x")
silent execute "nmap ]UU" maparg("]uu", "n")
silent execute "xmap ]UU" maparg("]uu", "x")
unmap [u
unmap [uu
unmap ]u
unmap ]uu
nnoremap ]u :UniteNext<CR>
nnoremap [u :UnitePrevious<CR>
