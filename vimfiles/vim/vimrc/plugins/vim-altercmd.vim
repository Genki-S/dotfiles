" Common altercmds are written in here
" filetype altercmds are written in ftplugin/*.vim

call altercmd#load()

" ==================================================
" Frequent commands
" ==================================================
AlterCommand m make
AlterCommand sf setfiletype
AlterCommand fl help function-list

" --------------------------------------------------
" Source stuffs
" --------------------------------------------------
AlterCommand so source %
" source line
AlterCommand sl execute getline('.')


" ==================================================
" Original commands
" ==================================================
AlterCommand ps PluginSetting
AlterCommand pi PluginInterface
AlterCommand psn PluginSetting neobundle.vim

AlterCommand eft execute 'edit $DOTDIR/vimfiles/vim/ftplugin/'.&filetype.'.vim'
