#!/usr/local/bin/zsh --no-rcs

# Exit on first error
set -e
if [[ -n $DEBUG ]]; then
	set -x
fi

# Report error position
function report_error() {
	echo "Error at $1 on line $2 with exit code $3"
}
trap 'report_error $0 ${LINENO} ${$?}' ERR

source $HOME/dotfiles/zshfiles/envfiles/env.zsh
cd $DOTDIR

# Create necessary directories
mkdir -p $HOME/.zhistlogs
mkdir -p $HOME/.tmp/vim/backup
mkdir -p $HOME/.tmp/vim/view
mkdir -p $HOME/.tmp/vim/undo

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
	gitfiles/gitconfig
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

echo "Remember to change your login shell!"
