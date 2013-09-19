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

# ==================================================
# Common settings
# ==================================================
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

# Use <C-@> to edit command line with $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^@' edit-command-line

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
