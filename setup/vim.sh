#!/bin/sh

mkdir -p $HOME/.vimbundles

# Install neobundle
git clone http://github.com/Shougo/neobundle.vim $HOME/.vimbundles/neobundle.vim

# Neobundle will do the rest.
command vim -c "NeoBundleInstall" -c "quit"

# Install my bundles
command vim -u $HOME/dotfiles/bundle_vimrc -c "NeoBundleInstall" -c "quit"
