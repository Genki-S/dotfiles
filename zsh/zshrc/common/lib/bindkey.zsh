function starteditor() {
	exec < /dev/tty
	${EDITOR}
	zle reset-prompt
}
zle -N starteditor
bindkey '\@' starteditor
