# Thanks: http://qiita.com/wada811/items/78b14181a4de0fd5b497
function peco_select_history() {
	local tac
	executable gtac && tac="gtac" || { executable tac && tac="tac" || { tac="tail -r" } }
	BUFFER=$( \
		builtin history -n 1 \
		| $tac \
		| awk '!a[$0]++' \
		| peco --query "$LBUFFER")
	CURSOR=$#BUFFER # move cursor
	zle -R -c # refresh
}
zle -N peco_select_history
bindkey '^R' peco_select_history
