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

" --------------------------------------------------
" Source stuffs
" --------------------------------------------------
AlterCommand so source %
" source line
AlterCommand sl execute getline('.')
" source session
AlterCommand ss source Session

" ==================================================
" Original commands
" ==================================================
AlterCommand ps PluginSetting
AlterCommand eb edit $DOTDIR/vimfiles/vim/bundles.yml
AlterCommand enb edit $DOTDIR/vimfiles/vim/neobundles.vim
AlterCommand eft execute 'edit $DOTDIR/vimfiles/vim/ftplugin/'.&filetype.'.vim'

" ==================================================
" Plugins
" ==================================================
AlterCommand nb Unite neobundle
AlterCommand nbi Unite -auto-quit neobundle/install
AlterCommand nbu Unite neobundle/update
AlterCommand nbc NeoBundleClean
AlterCommand nbl Unite neobundle/lazy
AlterCommand nbd NeoBundleDocs

AlterCommand nse NeoSnippetEdit -split -vertical
