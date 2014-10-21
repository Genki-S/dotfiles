# Save original path
ORIGINAL_PATH=$PATH

# Remove duplications
typeset -U path cdpath manpath fpath

# path(...): add only if condition(...) is true
#  N: NULL_GLOB option
#  -: follow symlink
#  /: directory

path=(
	$HOME/bin
	$HOME/dotfiles/bin
	$path
)

if is_mac; then
	path=(
		# Use gnu coreutils
		$(brew --prefix coreutils)/libexec/gnubin
		$path
		# texbin
		/usr/texbin
	)
fi

fpath=(
	$fpath
	$WIDGETDIR
	~/dotfiles/zshfiles/functions
)
