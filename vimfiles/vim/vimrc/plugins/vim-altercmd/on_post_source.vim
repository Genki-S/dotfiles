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
" source vimrc
AlterCommand sv source $MYVIMRC

" ==================================================
" Original commands
" ==================================================
AlterCommand ps PluginSetting

" e: edit
AlterCommand ev edit $MYVIMRC
AlterCommand eb edit $DOTDIR/vimfiles/vim/bundles.yml
AlterCommand enb edit $DOTDIR/vimfiles/vim/neobundles.vim
AlterCommand eft execute 'edit $DOTDIR/vimfiles/vim/ftplugin/'.&filetype.'.vim'
AlterCommand esw edit $DOTDIR/vimfiles/vim/vimrc/plugins/switch.vim/switch.yml

" v: view
AlterCommand vb edit $DOTDIR/vimfiles/vim/bundles

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

AlterCommand man Ref man
