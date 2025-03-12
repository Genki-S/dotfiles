call altercmd#load()

AlterCommand sf setfiletype
AlterCommand fl help<Space>function-list
AlterCommand tn tabnew
AlterCommand qt tabclose
AlterCommand ps PluginSetting

AlterCommand cclear call<Space>setqflist([])<Space>\\|<Space>cclose<Space>\\|<Space>call<Space>lightline#update()

" f: fold
" h stands for 'hand'
AlterCommand fmh setlocal<Space>foldmethod=manual
AlterCommand fmi setlocal<Space>foldmethod=indent
AlterCommand fme setlocal<Space>foldmethod=expr
AlterCommand fmm setlocal<Space>foldmethod=marker
AlterCommand fms setlocal<Space>foldmethod=syntax
AlterCommand fmd setlocal<Space>foldmethod=diff

" s: source
AlterCommand so source<Space>%
" source line
AlterCommand sl execute<Space>getline('.')

" e: edit
AlterCommand ev tabedit<Space>$MYVIMRC
AlterCommand ep tabedit<Space>$HOME/dotfiles/nvim/plugins.yaml
AlterCommand eft execute<Space>'tabedit<Space>$HOME/dotfiles/nvim/ftplugin/'.&filetype.'.vim'

" for plugins
AlterCommand tw TweetVimSay
AlterCommand qr QuickRun
AlterCommand dd DevDocs
AlterCommand nse call<Space>g:Neosnippet_edit_with_example()

" Misc.
AlterCommand pre Precommit
