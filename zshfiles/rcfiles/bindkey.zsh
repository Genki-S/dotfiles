# Use vi keybind
bindkey -v

# ==================================================
# Viins settings
# ==================================================

# ==================================================
# Vicmd settings
# ==================================================
bindkey -M vicmd 'yy' vi-yank-whole-line
bindkey -M vicmd 'Y' vi-yank-eol
bindkey -M vicmd 'cc' vi-change-whole-line
bindkey -M vicmd 'dd' kill-whole-line
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^r' redo

# Directory Mark
typeset -A zvi_dirmarks
# Load marks from database
zvi_dirmarks_save_file=$HOME/.zvi_dirmarks
source $zvi_dirmarks_save_file

autoload -U read-from-minibuffer

function zvi-list-dirmarks {
	for k in ${(k)zvi_dirmarks}
	do
		echo $k ":" $zvi_dirmarks[$k]
	done
}
function zvi-set-dirmark {
	local REPLY
	read-from-minibuffer -k 1 "Mark:"
	zvi_dirmarks[$REPLY]=`pwd`
	# Save marks
	echo "zvi_dirmarks=(${(kv)zvi_dirmarks})" > $zvi_dirmarks_save_file
}
function zvi-jump-dirmark {
	local REPLY
	read-from-minibuffer -k 1 "Mark:"
	if [[ -n $zvi_dirmarks[$REPLY] ]]; then
		cd $zvi_dirmarks[$REPLY]
	fi
	zle reset-prompt
}
zle -N zvi-set-dirmark
zle -N zvi-jump-dirmark
bindkey -M vicmd 'm' zvi-set-dirmark
bindkey -M vicmd '`' zvi-jump-dirmark

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
	echo "YOU ARE HERE"
	dirs -p
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
# For prompt
# ==================================================
function zle-line-init zle-keymap-select {
	zle reset-prompt
}
zle -N zle-keymap-select

function vi_command_mode_prompt_info() {
	if [[ $KEYMAP = "vicmd" ]]; then
		echo "M: VICMD"
	fi
}

# ==================================================
# My widgets
# ==================================================
# Mark all widgets for autoloading and
# Register zle widgets
for wgt in $WIDGETDIR/*
do
	autoload -U $wgt:t
	zle -N $wgt:t
done

bindkey '//' global-expansion-home-dir
# I mean '^/'. Only on mac?
bindkey '^_' global-expansion-marked-dir

# Tip: press <C-v><key> to get <key>'s keycode
