function peco_select_history() {
	local tac
	executable gtac && tac="gtac" || { executable tac && tac="tac" || { tac="tail -r" } }
	BUFFER=$(builtin history -n 1 | eval $tac | peco --query "$LBUFFER")
	CURSOR=$#BUFFER # move cursor
	zle -R -c # refresh
}
zle -N peco_select_history
bindkey '^R' peco_select_history
