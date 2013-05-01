if [[ $PLATFORM == "linux" ]]; then
	if [ -f /usr/share/autojump/autojump.zsh ]; then
		source /usr/share/autojump/autojump.zsh
	fi

elif [[ $PLATFORM == "mac" ]]; then
	if [ -f `brew --prefix`/etc/autojump.zsh ]; then
		source `brew --prefix`/etc/autojump.zsh
	fi
fi
