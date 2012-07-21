" ==================================================
" Solarized settings
" ==================================================
syntax enable
set t_Co=16
set background=dark
colorscheme solarized


" ==================================================
" Screen Visual
" ==================================================
set number
set cursorline

" Special Characters
set list
set listchars=tab:-\ ,trail:_,extends:>,precedes:<


" ==================================================
" Statusline
" ==================================================
set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=\ %{fugitive#statusline()}   " git information
set statusline+=%=                           " right align
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l/%L,%c%V%)\ %<%P     " offset
