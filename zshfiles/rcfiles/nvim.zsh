function myvim() {
  nvim $*
  if [[ -n "$VIM_AFTER_SOUND" && -f "$VIM_AFTER_SOUND" ]]; then
    # double fork (so that this won't be counted as background job of current shell)
    # https://stackoverflow.com/a/20338327
    ( ffplay -nodisp -autoexit -volume 100 "$VIM_AFTER_SOUND" &> /dev/null & )
  fi
}

alias v='myvim'

# Usage: vw EXECUTABLE
# vim `which EXECUTABLE`
function vw () {
	$EDITOR `which $*`
}

# vim:foldmethod=marker
