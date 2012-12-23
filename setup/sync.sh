# Symlink files I wanna sync via Dropbox

sync_root=$HOME/Dropbox/sync_root

function sync_it {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 SYNC_FILE"
		return
	fi
	local target=$1
	if [ ! -e $target ]; then
		echo "$target does not exist. Abort."
		return
	fi
	if [ -L $target ]; then
		echo "$target is symlink (maybe already synced?). Abort."
		return
	fi
	# TODO: comfirm if it is ok to move
	mkdir -p $sync_root${target%/*}
	mv $target $sync_root$target
}

function sync_linker {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 SYNC_FILE"
		return
	fi
	local link=$1
	local target=$sync_root$1
	if [ -e $link -a ! -L $link ]; then
		echo "$link exists and not a symlink file."
		if [ -e $target ]; then
			echo "$target also exists."
			echo "Maybe you want to merge $link and $target."
			echo "vim -d $link $target"
			echo "After merge, remove $link and run this script again."
			echo "Abort."
			return
		fi
		echo "Moving $link to appropreate directory..."
		sync_it $link
	fi
	if [ -L $link ]; then
		# Remove existing symlink
		rm $link
	fi
	if [ ! -e $target ]; then
		echo "$target does not exist. Abort."
		return
	fi
	ln -s $target $link
}

# Vimperator
sync_linker $HOME/.vimperator

# Firefox
sync_linker $HOME/.mozilla/firefox/profiles.ini
sync_linker $HOME/.mozilla/firefox/qtlp6vd2.default
sync_linker $HOME/.mozilla/firefox/hg3yf6t7.Study
sync_linker $HOME/.mozilla/firefox/mblrj487.Break
sync_linker $HOME/.mozilla/firefox/v6bute70.Development

# Tmuxinator
sync_linker $HOME/.tmuxinator

# Miscellaneous
sync_linker $HOME/random_reminders.txt
