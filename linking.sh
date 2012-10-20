#!/bin/bash

function symlink {
	CONFIRM=y
	if [ -e $HOME/$1 ]; then
		echo -n "$1 exists. override? [y/n]"
		read CONFIRM
	fi
	case $CONFIRM in
		y|Y|YES|yes|Yes)
			rm -f $HOME/$1
			echo "ln -s $HOME/dotfiles/$1 $HOME/$1"
			ln -s $HOME/dotfiles/$1 $HOME/$1 ;;
		* )
	esac
}

symlink .vimrc
symlink .vim
symlink .zshrc
symlink .tmux.conf
