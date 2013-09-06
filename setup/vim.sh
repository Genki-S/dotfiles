#!/bin/sh

# Install neobundle
if [ ! -d $DOTDIR/vimfiles/vim/bundles/neobundle.vim ]; then
	git clone http://github.com/Shougo/neobundle.vim $DOTDIR/vimfiles/vim/bundles/neobundle.vim
fi

# Neobundle will do the rest.
command vim -c "NeoBundleUpdate" -c "quit" || ;
