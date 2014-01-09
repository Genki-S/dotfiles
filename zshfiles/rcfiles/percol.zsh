function percol_select_history() {
	local tac
	executable gtac && tac="gtac" || { executable tac && tac="tac" || { tac="tail -r" } }
	BUFFER=$(builtin history -n 1 | eval $tac | percol --query "$LBUFFER")
	CURSOR=$#BUFFER # move cursor
	zle -R -c # refresh
}

zle -N percol_select_history
bindkey '^R' percol_select_history
