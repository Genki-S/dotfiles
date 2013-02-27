# This is a charm
# http://d.hatena.ne.jp/edvakf/20080929/1222657230
alias pbcopy="nkf -w | __CF_USER_TEXT_ENCODING=0x$(printf %x $(id -u)):0x08000100:14 pbcopy"

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
