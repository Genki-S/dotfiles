# ==================================================
# Platform check
# ==================================================
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

# ==================================================
# Path Settings
# ==================================================
# Remove duplications
typeset -U path cdpath manpath fpath

# path(...): add only if condition(...) is true
#  N: NULL_GLOB option
#  -: follow symlink
#  /: directory

path=( # My bin prevails over system bin
	$HOME/bin
	$HOME/dotfiles/bin
	# system bins
	/usr/local/bin
	/usr/bin
	/bin
	# pip
	/usr/local/share/python
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

# ==================================================
# Miscellaneous
# ==================================================
# Source rvm environment
which rails &> /dev/null
if [ $? -ne 0 ]; then
	source $HOME/.rvm/environments/default
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# ==================================================
# Env
# ==================================================
export HTTP_HOME=http://vim.wikia.com/wiki/Special:Random
export TERM=xterm-256color
export EDITOR=vim

export MYBUNDLES=$HOME/.mybundles

export RSENSE_HOME=$MYBUNDLES/rsense


# ==================================================
# My zshenv
# ==================================================
# Load all config files
if ls -U $HOME/dotfiles/zsh/zshenv/common/**/*.zsh &> /dev/null; then
	for config_file ($HOME/dotfiles/zsh/zshenv/common/**/*.zsh) source $config_file
fi
if ls -U $HOME/dotfiles/zsh/zshenv/$PLATFORM/**/*.zsh &> /dev/null; then
	for config_file ($HOME/dotfiles/zsh/zshenv/$PLATFORM/**/*.zsh) source $config_file
fi
