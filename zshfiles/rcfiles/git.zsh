# Use hub
function git() {
	hub $*
	__EXECUTED_GIT_COMMAND=1
}

# ghi -- github issues from command line
export GHI_TOKEN=`cat ~/private_files/ghi_token`

# Sugers
alias gf="git diff --color"
alias gfc="git diff --color --cached"
alias gr="git reset"
alias grh~="git reset HEAD~"
alias grh\^="git reset 'HEAD^'"
alias gcam="git commit --amend"
alias gt="git tag"
alias grb="git rebase"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias gsl="git stash list"
alias gss="git stash save"
alias gsf="git stash show"
alias gsp="git stash pop"
# github issues
alias gjob="ghi list --mine"
alias gis="ghi show"
alias gic="ghi comment"
# git-pulls
alias gpr="git pulls"
alias gpru="git pulls update"
alias gprl="git pulls list"
alias gprc="git pulls checkout"
alias gprs="git pulls show"
alias gprb="git pulls browse"
alias gprm="git pulls merge"
