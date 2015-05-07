" Using `setlocal filetype` instead of `setfiletype` in order to override 'modula2' detection
" FIXME: this is really really slow... see: ./tmux.vim
"        for now, setting markdown filetype in ../ftplugin/modula2.vim (which is not slow)
" au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} setlocal filetype=markdown
