# ==================================================
# Frequent commands
# ==================================================
alias l="ls"
alias la="ls -a"
alias ax="atool -x"
alias hist="fc -liD 1"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias sz="source $HOME/.zshenv && source $HOME/.zshrc"
function mkcd () {
	mkdir -p "$@" && eval cd "\"\$$#\""
}

# ==================================================
# Global aliases
# ==================================================
alias -g G="| grep -i"
alias -g V="| grep -v"

# ==================================================
# Git
# ==================================================
alias gf="git diff --color"
alias gr="git reset"
alias grh~="git reset HEAD~"
alias grh\^="git reset 'HEAD^'"
alias gcam="git commit --amend"

# ==================================================
# Tmux related
# ==================================================
alias ms="mux start"


# ==================================================
# Platform specific
# ==================================================
if [[ $PLATFORM == "linux" ]]; then
	alias x="xdg-open"
	alias ack="ack-grep"

elif [[ $PLATFORM == "mac" ]]; then
	alias x="open"

	# This is a charm
	# http://d.hatena.ne.jp/edvakf/20080929/1222657230
	alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"

	# Brew
	alias b="brew"
	alias bu="brew update"
	alias bs="brew search"
	function bi() {
		if [ $# -gt 0 ]; then
			brew install $*
		else
			last_command=$history[$[HISTCMD-1]]
			last_command_array=("${(s/ /)last_command}")
			if [ "$last_command_array[1]" = "bs" ]; then
				brew install $last_command_array[-1]
			else
				brew install
			fi
		fi
	}
	alias bdr="cd $(brew --repository)"
	alias bdc="cd $(brew --cellar)"
fi
