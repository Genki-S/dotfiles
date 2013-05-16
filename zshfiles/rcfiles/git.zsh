# Use hub
function git() {
	hub $*
	__EXECUTED_GIT_COMMAND=1
}

# ghi -- github issues from command line
export GHI_TOKEN=`cat ~/private_files/ghi_token`

# Sugers
alias gf="git diff --color"
alias gr="git reset"
alias grh~="git reset HEAD~"
alias grh\^="git reset 'HEAD^'"
alias gcam="git commit --amend"
