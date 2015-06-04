# Got ideas from these:
#   http://superuser.com/questions/553564/is-there-a-way-to-make-zsh-run-a-command-after-reporttime
#   http://brettterpstra.com/2012/08/02/a-drop-in-growlnotify-replacement-for-mountain-lion-notifications/
#   https://github.com/alloy/terminal-notifier

__ZSH_NOTIFIER_EXCLUDE_COMMANDS=(
	myvim
	git
	tig
)

if executable terminal-notifier; then
	notify-preexec-hook() {
		zsh_notifier_cmd="$1"
		zsh_notifier_raw_cmd="$2"
		zsh_notifier_time="`date +%s`"
	}

	notify-precmd-hook() {
		local raw_cmd=${zsh_notifier_raw_cmd%% *}
		if [ ${__ZSH_NOTIFIER_EXCLUDE_COMMANDS[(i)${raw_cmd}]} -le ${#__ZSH_NOTIFIER_EXCLUDE_COMMANDS} ]; then
			return
		fi

		local time_taken
		if [[ "${zsh_notifier_cmd}" != "" ]]; then
			time_taken=$(( `date +%s` - ${zsh_notifier_time}  ))
			if (( $time_taken > $REPORTTIME  )); then
				# FIXME: dirty hack to use reattach-to-user-namespece
				#        see: https://github.com/alloy/terminal-notifier/issues/115
				reattach-to-user-namespace terminal-notifier -title "Task Finished" \
					-message "'$zsh_notifier_cmd' exited after $time_taken seconds"
			fi
		fi
		zsh_notifier_cmd=
		zsh_notifier_raw_cmd=
	}
fi

ring()
{
	echo -n ''
}

preexec_functions+=(notify-preexec-hook)
precmd_functions+=(notify-precmd-hook ring)
