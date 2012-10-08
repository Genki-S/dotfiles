# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/genki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# PATH setting
# Add: path to texlive
export PATH=$PATH:/usr/local/texlive/2011/bin/i386-linux/
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# ==================================================
# Aliases
# ==================================================
alias vim="vim --servername genki" # in order to use AsyncCommand
alias hist="fc -liD 1"
alias ev="vim ~/dotfiles/.vimrc"
alias ez="vim ~/dotfiles/.zshrc"
alias ack="ack-grep"

# ==================================================
# Functions
# ==================================================
function clear() { echo "Don't bother to type \"clear\"! Just use <C-L>." }
function touch() { echo "Don't bother to type \"touch\"! Just use \"> filename\"." }

# ==================================================
# Linux 101 Hacks
# ==================================================
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
# cd -
# dirs, pushd, popd
# shopt -s cdspell (not for zsh)

# ==================================================
# History settings
# ==================================================
setopt EXTENDED_HISTORY

# ==================================================
# Environment Variables
# ==================================================
export HTTP_HOME=http://vim.wikia.com/wiki/Special:Random
export TERM=xterm-256color

# ==================================================
# Miscellaneous
# ==================================================
# RescueTime
ps -e | grep rescuetime &> /dev/null
if [ $? -ne 0 ]; then
	if which rescuetime &> /dev/null; then
		screen -d -m rescuetime
	else
		echo "You should install RescueTime, really."
	fi
fi

# AutoJump
if [ -f /usr/share/autojump/autojump.zsh ]; then
	source /usr/share/autojump/autojump.zsh
else
	echo "You should install autojump, really."
fi
