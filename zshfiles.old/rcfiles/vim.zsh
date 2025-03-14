function myvim() {
	local session_option=""
	if [ $# -eq 0 -a -f Session.vim ]; then
		session_option="-S"
	fi

	local startuptime_file="$HOME/.tmp/profiling/vim/`date "+%Y%m%d_%H%M%S"`"

	nvim $session_option --startuptime $startuptime_file $*
	local code=$?

	__EXECUTED_GIT_COMMAND=1
	echo "vim startup: `tail -n1 $startuptime_file | cut -d' ' -f1` ms."
	return $code
}

alias v="myvim"
alias ev="v ~/dotfiles/vimrc"
alias ez="v ~/dotfiles/zshrc"
alias et="v ~/dotfiles/tmux.conf"

# Log viewer
alias lv="v +'set ft=log'"
