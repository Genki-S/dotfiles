# Symlink files I wanna sync via Dropbox

sync_root=$HOME/Dropbox/sync_root

function sync_linker {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 SYNC_FILE"
		return
	fi
	local link=$1
	local file=$sync_root$1
	if [ -e $link -a ! -L $link ]; then
		echo "$link exists and not a symlink file. Abort."
		return
	fi
	if [ ! -e $file ]; then
		echo "Warning: $file does not exist."
	fi
	echo "ln -s" $file $link
	ln -s $file $link
}

sync_linker $HOME/.vimperator
