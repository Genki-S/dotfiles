#!/bin/sh

mkdir -p $HOME/.vimbundles

# Install neobundle
if [ ! -d $HOME/.vimbundles/neobundle.vim ]; then
	git clone http://github.com/Shougo/neobundle.vim $HOME/.vimbundles/neobundle.vim
fi

# Neobundle will do the rest.
command vim -c "NeoBundleInstall" -c "quit" || ;
