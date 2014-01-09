call altercmd#load()

" Common altercmds are written in here
" filetype altercmds are written in ftplugin/*.vim

" ==================================================
" Frequent commands
" ==================================================
AlterCommand m make
AlterCommand sf setfiletype
AlterCommand fl help function-list
AlterCommand tn tabnew
AlterCommand qt tabclose

" s: source
AlterCommand so source %
" source line
AlterCommand sl execute getline('.')
AlterCommand ss source Session
AlterCommand sv source $MYVIMRC

" e: edit
AlterCommand ev tabedit $MYVIMRC
AlterCommand eb tabedit $DOTDIR/vimfiles/vim/bundles.yml
AlterCommand enb tabedit $DOTDIR/vimfiles/vim/neobundles.vim
AlterCommand eft execute 'tabedit $DOTDIR/vimfiles/vim/ftplugin/'.&filetype.'.vim'
AlterCommand esw tabedit $DOTDIR/vimfiles/vim/vimrc/plugins/switch.vim/switch.yml

" v: view
AlterCommand vb edit $DOTDIR/vimfiles/vim/bundles

" ==================================================
" Original commands
" ==================================================
AlterCommand ps PluginSetting
