if [[ $PLATFORM == "mac" ]]; then
	VIM=/usr/local/bin/vim
elif [[ $PLATFORM == "linux" ]]; then
fi

export MANPAGER="$SHELL -c \"col -b | $VIM -c 'setfiletype man' -\""
export LESSCHARSET="utf-8"

# Report time if a program takes more than 3 seconds
REPORTTIME=3
