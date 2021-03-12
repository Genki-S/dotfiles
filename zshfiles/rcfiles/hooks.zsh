# NLCF: Notify Long-running Command Finish {{{
# Got ideas from these:
#   http://superuser.com/questions/553564/is-there-a-way-to-make-zsh-run-a-command-after-reporttime
#   http://brettterpstra.com/2012/08/02/a-drop-in-growlnotify-replacement-for-mountain-lion-notifications/
#   https://github.com/alloy/terminal-notifier

REPORTTIME_SECONDS=3
NLCF_EXCLUDE_COMMANDS=(
  nvim
  myvim
  git
  tig
  fg
  man
  tmux
  htop
  ssh
)

NLCF_SUCCESS_SOUNDS=()
NLCF_FAILURE_SOUNDS=()

nlcf-preexec-hook() {
  zsh_notifier_cmd="$1"
  zsh_notifier_raw_cmd="$2"
  zsh_notifier_time="`date +%s`"
}

nlcf-precmd-hook() {
  local exit_code=$?

  if [ -z "$zsh_notifier_time" ]; then
    return
  fi

  local raw_cmd=${zsh_notifier_raw_cmd%% *}
  if [ ${NLCF_EXCLUDE_COMMANDS[(i)${raw_cmd}]} -le ${#NLCF_EXCLUDE_COMMANDS} ]; then
    return
  fi

  local time_taken
  time_taken=$(( `date +%s` - ${zsh_notifier_time}  ))

  if [[ "${zsh_notifier_cmd}" != "" ]]; then
    if (( $time_taken > $REPORTTIME_SECONDS  )); then
      my-notification "Command finished" "$raw_cmd exited after $time_taken seconds with exit code $exit_code"
      if [[ ${#NLCF_SUCCESS_SOUNDS} -gt 0 && $exit_code -eq 0 ]]; then
        local len=${#NLCF_SUCCESS_SOUNDS}
        local idx=$(( $[${RANDOM}%${len}] + 1 ))
        local sound=${NLCF_SUCCESS_SOUNDS[${idx}]}
        # double fork (so that this won't be counted as background job of current shell)
        # https://stackoverflow.com/a/20338327
        ( ffplay -nodisp -autoexit -volume 5 "$sound" &> /dev/null & )
      fi
      if [[ ${#NLCF_FAILURE_SOUNDS} -gt 0 && $exit_code -ne 0 ]]; then
        local len=${#NLCF_FAILURE_SOUNDS}
        local idx=$(( $[${RANDOM}%${len}] + 1 ))
        local sound=${NLCF_FAILURE_SOUNDS[${idx}]}
        ( ffplay -nodisp -autoexit -volume 5 "$sound" &> /dev/null & )
      fi
    fi
  fi
  zsh_notifier_cmd=
  zsh_notifier_raw_cmd=
}
# }}}

preexec_functions+=(nlcf-preexec-hook)
precmd_functions+=(nlcf-precmd-hook)

# vim: foldmethod=marker
