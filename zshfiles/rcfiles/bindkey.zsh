typeset -a zvi_jumplist
zvi_jumplist_valid_dirs_num=0
# Assume autopush is set
function zvi-jump-backward {
	if [[ `dirs -p | wc -l` -ne $zvi_jumplist_valid_dirs_num ]]; then
		zvi_jumplist=()
	fi
	if [[ `dirs -p | wc -l` -eq 1 ]]; then
		read-from-minibuffer -k 1 "No more list backward"
	else
		zvi_jumplist+=(`pwd`)
		popd > /dev/null
		zvi_jumplist_valid_dirs_num=`dirs -p | wc -l`
		zle reset-prompt
	fi
}
function zvi-jump-forward {
	if [[ `dirs -p | wc -l` -ne $zvi_jumplist_valid_dirs_num ]]; then
		zvi_jumplist=()
	fi
	if [[ ${#zvi_jumplist} -eq 0 ]]; then
		read-from-minibuffer -k 1 "No more list forward"
	else
		cd $zvi_jumplist[-1]
		zvi_jumplist[-1]=()
		zvi_jumplist_valid_dirs_num=`dirs -p | wc -l`
		zle reset-prompt
	fi
}
function zvi-list-jumplist {
	if [[ `dirs -p | wc -l` -ne $zvi_jumplist_valid_dirs_num ]]; then
		zvi_jumplist=()
	fi
	for d in $zvi_jumplist
	do
		echo $d
	done
	echo "\033[31m`dirs -lp | awk '{if (NR == 1) print}'`\033[0m"
	dirs -lp | awk '{if (NR > 1) print}'
}
function zvi-clear-jumplist {
	zvi_jumplist=()
	dirs -c
}
zle -N zvi-jump-backward
zle -N zvi-jump-forward
bindkey '^o' zvi-jump-backward
bindkey '\\^o' zvi-jump-forward

# http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
function fancy-ctrl-z() {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER="fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}
zle -N fancy-ctrl-z
bindkey '^z' fancy-ctrl-z

# complete words from tmux pane(s)
# Source: https://gist.github.com/blueyed/6856354
_tmux_pane_words() {
  local expl
  local -a w
  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi
  # capture current pane first
  w=( ${(u)=$(tmux capture-pane -J -p)} )
  for i in $(tmux list-panes -F '#P'); do
    # skip current pane (handled above)
    [[ "$TMUX_PANE" = "$i" ]] && continue
    w+=( ${(u)=$(tmux capture-pane -J -p -t $i)} )
  done
  _wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^x^tt' tmux-pane-words-prefix
bindkey '^x^tT' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
# display the (interactive) menu on first execution of the hotkey
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' menu yes select interactive
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'

# complete the output from previous command
# http://www.zsh.org/mla/users/2004/msg00893.html
_jh-prev-result () {
    hstring=$(eval `fc -l -n -1`)
    set -A hlist ${(@s/
/)hstring}
    compadd - ${hlist}
}
zle -C jh-prev-comp menu-complete _jh-prev-result
bindkey '^x^p' jh-prev-comp

# ==================================================
# Common settings
# ==================================================
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# Use <C-@> to edit command line with $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^@' edit-command-line

# ==================================================
# Builtin (http://zshwiki.org/home/builtin/start)
# ==================================================
autoload -U zmv

# ==================================================
# My widgets
# ==================================================
# Dependencies
autoload -Uz narrow-to-region

# Mark all widgets for autoloading and
# Register zle widgets
for wgt in $WIDGETDIR/*
do
	autoload -U $wgt:t
	zle -N $wgt:t
done

bindkey '/' global-expansion-home-dir
bindkey '^r' history-incremental-preserving-pattern-search-backward
bindkey -M isearch '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# Tip: press <C-v><key> to get <key>'s keycode
