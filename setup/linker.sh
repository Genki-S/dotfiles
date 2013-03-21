#!/bin/bash

# ==================================================
# Dotfiles
# ==================================================
function symlink_dot {
	local symlink_src=$1
	local symlink_dest=.$1
	if [ -e $HOME/$symlink_dest ]; then
		echo -n "$symlink_dest exists."
	fi
	ln -s $HOME/dotfiles/$symlink_src $HOME/$symlink_dest
}

symlink_dot vimrc
symlink_dot vim
symlink_dot zshrc
symlink_dot zshenv
symlink_dot tmux.conf
symlink_dot ctags
symlink_dot latexmkrc
symlink_dot vimperatorrc
symlink_dot git_template

# ==================================================
# My bundles
# ==================================================
function symlink_bundle {
	local src=$1
	local dst=$HOME/bin/${1##*/} # trim directory(ies)
	dst=${dst%%.*} # trim extension(s)
	if [ -L $dst ]; then
		rm -f $dst
	fi
	echo "ln -s $src $dst"
	ln -s $src $dst
}

symlink_bundle $MYBUNDLES/js-beautify/python/js-beautify
symlink_bundle $MYBUNDLES/tidy-html5/bin/tidy

PEG=$MYBUNDLES/peg-multimarkdown
for f in $PEG/multimarkdown $PEG/scripts/*
do
	symlink_bundle $f
done
