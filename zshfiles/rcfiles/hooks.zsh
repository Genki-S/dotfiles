# Notify when long-running command finishes
# Got ideas from these:
#   http://superuser.com/questions/553564/is-there-a-way-to-make-zsh-run-a-command-after-reporttime
#   http://brettterpstra.com/2012/08/02/a-drop-in-growlnotify-replacement-for-mountain-lion-notifications/
#   https://github.com/alloy/terminal-notifier

REPORTTIME_SECONDS=3
NOTIFY_EXCLUDE_COMMANDS=(
  nvim
  git
  tig
  fg
  man
)

notify-preexec-hook() {
  zsh_notifier_cmd="$1"
  zsh_notifier_raw_cmd="$2"
  zsh_notifier_time="`date +%s`"
}

notify-precmd-hook() {
  if [ -z "$zsh_notifier_time" ]; then
    return
  fi

  local raw_cmd=${zsh_notifier_raw_cmd%% *}
  if [ ${NOTIFY_EXCLUDE_COMMANDS[(i)${raw_cmd}]} -le ${#NOTIFY_EXCLUDE_COMMANDS} ]; then
    return
  fi

  local time_taken
  time_taken=$(( `date +%s` - ${zsh_notifier_time}  ))

  if [[ "${zsh_notifier_cmd}" != "" ]]; then
    if (( $time_taken > $REPORTTIME_SECONDS  )); then
      my-notification "Command finished" "$raw_cmd exited after $time_taken seconds"
    fi
  fi
  zsh_notifier_cmd=
  zsh_notifier_raw_cmd=
}

preexec_functions+=(notify-preexec-hook)
precmd_functions+=(notify-precmd-hook ring)
