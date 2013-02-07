# Platform check
case $OSTYPE in
	darwin*)
		PLATFORM='mac'
		;;
	linux*)
		PLATFORM='linux'
		;;
	*)
		PLATFORM='unknown'
		;;
esac

# Remove duplications
typeset -U path cdpath manpath fpath

# path(...): add only if condition(...) is true
#  N: NULL_GLOB option
#  -: follow symlink
#  /: directory

path=( # My bin prevails over system bin
	$HOME/bin
	# system bins
	/usr/local/bin
	/usr/bin
	/bin
	# texlive
	/usr/local/texlive/2012/bin/i386-linux
)

case $PLATFORM in
	mac)
		path=($(brew --prefix coreutils)/libexec/gnubin
			$path
			)
		;;
esac

export HTTP_HOME=http://vim.wikia.com/wiki/Special:Random
export TERM=xterm-256color
export EDITOR=vim

export MYBUNDLES=$HOME/.mybundles
