function myvim() {
	vimentor vim --servername genki $*
	__EXECUTED_GIT_COMMAND=1
}

alias vim="echo 'You can issue v alias instead.'"
alias v="myvim"
alias ev="v ~/dotfiles/vimrc"
alias ez="v ~/dotfiles/zshrc"
alias et="v ~/dotfiles/tmux.conf"
