# Use emacs bindings in insert mode, but provide some vi-like bindings
bindkey -e
bindkey '^[' vi-cmd-mode
# reduce delay to enter vi-cmd-mode : https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1

() { # Load my widgets
  local dependencies=(
    read-from-minibuffer
  )
  for d in $dependencies
  do
    autoload -U $d
  done

  local widget_dir=$HOME/dotfiles/zshfiles/rcfiles/widgets

  fpath=(
    $fpath
    $widget_dir
  )

  for wgt in $widget_dir/*
  do
    autoload -U $wgt:t
    zle -N $wgt:t
  done
}

bindkey ' ' magic-space
bindkey '^z' foreground
bindkey '^r' interactive-reverse-i-search
bindkey '^o' popd-in-place
bindkey '^I' expand-or-complete-with-dots
bindkey '^J' expand-alias-and-accept
