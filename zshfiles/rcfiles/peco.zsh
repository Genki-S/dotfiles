function peco_select_history() {
	local tac
	executable gtac && tac="gtac" || { executable tac && tac="tac" || { tac="tail -r" } }
	BUFFER=$(builtin history -n 1 | eval $tac | peco --query "$LBUFFER")
	CURSOR=$#BUFFER # move cursor
	zle -R -c # refresh
}
zle -N peco_select_history
bindkey '^R' peco_select_history

# http://qiita.com/dai___chi/items/b71fe99339bdbe5b5347
function pbsearch() {
	clipMenuPath="$HOME/Library/Application Support/ClipMenu"
	plutil -convert xml1 $clipMenuPath/clips.data -o - \
		| awk '/<string>/,/<\/string>/' \
		| awk 1 ORS='<BR>' \
		| sed -e "s/<string>//g" -e "s/<\\/string><BR>/\n/g" \
		| tail -n +15 \
		| sed '/^$/d'| cat -n | sort -k 2| uniq -f1 | sort -k 1 \
		| sed -e 's/^ *[0-9]*//g' \
		| sed -e 's/^\s*//g' \
		| peco \
		| sed -e 's/<BR>/\
/g' \
		| sed -e 's/&lt;/</g' -e 's/&gt;/>/g' \
		| reattach-to-user-namespace pbcopy
	zle -R -c # refresh
};
zle -N pbsearch
bindkey '^[p' pbsearch
alias pbs="pbsearch"
