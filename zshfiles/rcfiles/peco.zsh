function peco_select_history() {
	local tac
	executable gtac && tac="gtac" || { executable tac && tac="tac" || { tac="tail -r" } }
	BUFFER=$( \
		builtin history 1 \
		| sort -k2 \
		| uniq --skip-fields=1 \
		| sort -n -k1 \
		| sed 's/^ *//' \
		| cut -d' ' -f 2- \
		| sed 's/^ *//' \
		| peco --query "$LBUFFER")
	CURSOR=$#BUFFER # move cursor
	zle -R -c # refresh
}
zle -N peco_select_history
bindkey '^R' peco_select_history
