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
AlterCommand sol execute getline('.')


" ==================================================
" Original commands
" ==================================================
AlterCommand ps PluginSetting
AlterCommand psa PluginSettingAfter
AlterCommand psn PluginSetting neobundle.vim
