call altercmd#load()

AlterCommand sf setfiletype
AlterCommand fl help function-list
AlterCommand tn tabnew
AlterCommand qt tabclose
AlterCommand ps PluginSetting

" f: fold
" h stands for 'hand'
AlterCommand fmh setlocal foldmethod=manual
AlterCommand fmi setlocal foldmethod=indent
AlterCommand fme setlocal foldmethod=expr
AlterCommand fmm setlocal foldmethod=marker
AlterCommand fms setlocal foldmethod=syntax
AlterCommand fmd setlocal foldmethod=diff

" s: source
AlterCommand so source %
" source line
AlterCommand sl execute getline('.')

" e: edit
AlterCommand ev tabedit $MYVIMRC
AlterCommand ep tabedit $DOTDIR/nvim/plugins.yaml
AlterCommand eft execute 'tabedit $DOTDIR/nvim/ftplugin/'.&filetype.'.vim'


" TweetVim
AlterCommand tw TweetVimSay
