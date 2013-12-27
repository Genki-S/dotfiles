# Got ideas from these:
#   http://superuser.com/questions/553564/is-there-a-way-to-make-zsh-run-a-command-after-reporttime
#   http://brettterpstra.com/2012/08/02/a-drop-in-growlnotify-replacement-for-mountain-lion-notifications/
#   https://github.com/alloy/terminal-notifier

if executable terminal-notifier; then
	notify-preexec-hook() {
		zsh_notifier_cmd="$1"
		zsh_notifier_time="`date +%s`"
	}

	notify-precmd-hook() {
		local time_taken
		if [[ "${zsh_notifier_cmd}" != "" ]]; then
			time_taken=$(( `date +%s` - ${zsh_notifier_time}  ))
			if (( $time_taken > $REPORTTIME  )); then
				terminal-notifier -title "Task Finished" \
					-message "'$zsh_notifier_cmd' exited after $time_taken seconds"
			fi
		fi
		zsh_notifier_cmd=
	}
fi

ring()
{
	echo -n ''
}

preexec_functions+=(notify-preexec-hook)
precmd_functions+=(notify-precmd-hook ring)
