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

if [[ $PLATFORM == "linux" ]]; then
	path=(
		$path
		# pip
		/usr/local/share/python
		# texlive
		/usr/local/texlive/2012/bin/i386-linux
	)
fi

if [[ $PLATFORM == "mac" ]]; then
	path=(
		# Use gnu coreutils
		$(brew --prefix coreutils)/libexec/gnubin
		# Brew bin prevails
		/usr/local/bin
		$path
		# texbin
		/usr/texbin
	)
fi
