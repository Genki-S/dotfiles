" TODO: Understand what's going on
"   I don't know why, but this makes Vim startup really really slow.
"   Maybe many FileType events are occuring.
"   `:filetype detect` become slow with this setting.
"   However, for some reason, without this line `:filetype detect` become faster.
"   neobundle.vim: revision fd15e35a7a7c4e84ae62981cfa529ae7cc382330
"   vim-tmux: revision bc7f39f0564c33cc8ba8df52575e908892fc6982
" autocmd BufNewFile,BufRead {.,}tmux*.conf set filetype=tmux | compiler tmux
