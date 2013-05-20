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
