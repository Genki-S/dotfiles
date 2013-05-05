function show_full_command() {
	prevcmd=`previous_command`
	echo "FULL COMMAND:" `full_command $prevcmd` "\n"
}
preexec_functions+=(show_full_command)
