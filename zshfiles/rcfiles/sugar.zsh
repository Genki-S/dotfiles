# ==================================================
# Frequent commands
# ==================================================
alias ls="ls --color --classify"
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

# get-shit-done
function get-shit-done () {
	(cd $MYBUNDLES/get-shit-done; ./get-shit-done $@)
}

# ==================================================
# Global aliases
# ==================================================
alias -g G="| grep -i"
alias -g V="| grep -v"
alias -g S="| sed"
alias -g P="| $PAGER"
alias -g T="| tee"
alias -g X="| xargs_with_alias"
alias -g L="| extract_line"
alias -g PB="| reattach-to-user-namespace pbcopy"

# output modification
alias -g CHOP='| awk "length < 1024 { print }"'

# ==================================================
# Tmux related
# ==================================================
alias ms="mux start"
alias mo="mux open"

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

	# Unzip which can extract fxcking Japanese zip
	alias junzip='/usr/local/bin/unzip -Ocp932'

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
