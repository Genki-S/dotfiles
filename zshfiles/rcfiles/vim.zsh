function myvim() {
	local startuptime_file="$HOME/.tmp/profiling/vim/`date "+%Y%m%d_%H%M%S"`"
	vim --startuptime $startuptime_file $*
	__EXECUTED_GIT_COMMAND=1
	echo "vim startup: `tail -n1 $startuptime_file | cut -d' ' -f1` ms."
}

alias v="myvim"
alias ev="v ~/dotfiles/vimrc"
alias ez="v ~/dotfiles/zshrc"
alias et="v ~/dotfiles/tmux.conf"
