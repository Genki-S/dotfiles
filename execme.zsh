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

# Git submodule setup
git submodule init
git submodule update

# Generate some dotfiles
(cd $DOTDIR/gitfiles; $DOTDIR/bin/cook)

# Launchd deployments
if [ $PLATFORM == 'mac' ]; then
	for plist in $DOTDIR/miscfiles/launchd/*.haml
	do
		haml < $plist > $HOME/Library/LaunchAgents/${${plist##*/}%.haml}
	done
	root_plists=(
		genki.get-shit-done.work.plist
		genki.get-shit-done.play.plist
	)
	for plist in $root_plists
	do
		sudo mv $HOME/Library/LaunchAgents/$plist /Library/LaunchAgents/$plist
	done
fi

# Source other setups
source $DOTDIR/setup/git.sh
source $DOTDIR/setup/vim.sh
source $DOTDIR/setup/mybundle.sh

echo "Remember to change your login shell!"
