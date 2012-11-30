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
" NeoBundle
" ==================================================
AlterCommand nb Unite neobundle
AlterCommand nbi Unite -auto-quit neobundle/install
AlterCommand nbu Unite neobundle/update
AlterCommand nbc NeoBundleClean
AlterCommand nbl Unite neobundle/lazy
