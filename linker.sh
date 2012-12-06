#!/bin/bash

# ==================================================
# Dotfiles
# ==================================================
function symlink_dot {
	symlink_src=$1
	symlink_dest=.$1
	CONFIRM=n
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

symlink_dot vimrc
symlink_dot vim
symlink_dot zshrc
symlink_dot tmux.conf
symlink_dot ctags
symlink_dot latexmkrc

if [ ! -L $ZSH/themes/genki.zsh-theme ]; then
	echo "ln -s $HOME/dotfiles/genki.zsh-theme $ZSH/themes/genki.zsh-theme"
	ln -s $HOME/dotfiles/genki.zsh-theme $ZSH/themes/genki.zsh-theme
fi

# ==================================================
# My bundles
# ==================================================
function symlink_bundle {
	src=$1
	dest=$HOME/bin/${1##*/} # trim directory(ies)
	dest=${dest%%.*} # trim extension(s)
	echo "ln -s $src $dest"
	ln -s $src $dest
}

symlink_bundle $MYBUNDLES/js-beautify/python/js-beautify
symlink_bundle $MYBUNDLES/tidy-html5/bin/tidy
