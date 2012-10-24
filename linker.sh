#!/bin/bash

function symlink {
	symlink_src=$1
	symlink_dest=.$1
	CONFIRM=y
	if [ -e $HOME/$symlink_dest ]; then
		echo -n "$symlink_dest exists. override? [y/n]"
		read CONFIRM
	fi
	case $CONFIRM in
		y|Y|YES|yes|Yes)
			rm -f $HOME/$symlink_dest
			echo "ln -s $HOME/dotfiles/$symlink_src $HOME/$symlink_dest"
			ln -s $HOME/dotfiles/$symlink_src $HOME/$symlink_dest ;;
		* )
	esac
}

symlink vimrc
symlink vim
symlink zshrc
symlink tmux.conf

if [ ! -L $ZSH/themes/genki.zsh-theme ]; then
	ln -s $HOME/dotfiles/genki.zsh-theme $ZSH/themes/genki.zsh-theme
fi
