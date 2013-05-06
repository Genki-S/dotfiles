#!/usr/local/bin/zsh

# Exit on first error
set -e

DOTDIR=$HOME/dotfiles
cd $DOTDIR

# Create necessary directories
mkdir -p $HOME/.zhistlogs
mkdir -p $HOME/.tmp/vim/backup
mkdir -p $HOME/.tmp/vim/view

# Git submodule setup
git submodule init
git submodule update

# Generate some dotfiles
(cd $DOTDIR/gitfiles; $DOTDIR/bin/cook)

# Link dotfiles
dotfiles=(
	zshfiles/zshrc
	zshfiles/zshenv
	vimfiles/vim
	vimfiles/vimrc
	rubyfiles/pryrc
	gitfiles/git_template
	gitfiles/gitignore_global
	miscfiles/ctags
	miscfiles/latexmkrc
	miscfiles/tmux.conf
	miscfiles/vimperatorrc
	)

for f in $dotfiles
do
	basename=${f##*/}
	dotname=.$basename
	basefile=$DOTDIR/$f
	dotfile=$HOME/$dotname
	if [[ -L $dotfile ]]; then rm $dotfile; fi
	ln -s $basefile $dotfile
done

# Source other setups
source $DOTDIR/setup/git.sh
source $DOTDIR/setup/vim.sh
source $DOTDIR/setup/mybundle.sh
source $DOTDIR/setup/tagmaker.sh
