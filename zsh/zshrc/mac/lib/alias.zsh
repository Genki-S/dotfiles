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
