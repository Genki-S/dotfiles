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
AlterCommand lcdb lcd %:p:h

" make it easy to change fold methids
" h stands for 'hand'
AlterCommand fmh set foldmethod=manual
AlterCommand fmi set foldmethod=indent
AlterCommand fme set foldmethod=expr
AlterCommand fmm set foldmethod=marker
AlterCommand fms set foldmethod=syntax
AlterCommand fmd set foldmethod=diff

" s: source
AlterCommand so source %
" source line
AlterCommand sl execute getline('.')
AlterCommand ss source Session
AlterCommand sv source $MYVIMRC

" e: edit
AlterCommand ev tabedit $MYVIMRC
AlterCommand eb tabedit $DOTDIR/vimfiles/vim/bundles.yml
AlterCommand enb tabedit $DOTDIR/vimfiles/vim/neobundle.vim
AlterCommand eft execute 'tabedit $DOTDIR/vimfiles/vim/ftplugin/'.&filetype.'.vim'
AlterCommand esw tabedit $DOTDIR/vimfiles/vim/vimrc/plugins/switch.vim/switch.yml

" ==================================================
" Original commands
" ==================================================
AlterCommand ps PluginSetting
AlterCommand gg Google
