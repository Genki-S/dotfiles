function show_which() {
	prevcmd=`previous_command`
	echo "which:" `which ${prevcmd%% *}` "\n"
}
# preexec_functions+=(show_which)
