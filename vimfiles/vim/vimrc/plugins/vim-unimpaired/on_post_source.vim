" Override some mappings

" Quickfix/Location windows
nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap [ol :lopen<CR>
nnoremap ]ol :lclose<CR>

unmap [u
unmap [uu
unmap ]u
unmap ]uu
nnoremap ]u :UniteNext<CR>
nnoremap [u :UnitePrevious<CR>
