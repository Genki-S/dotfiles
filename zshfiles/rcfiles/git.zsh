# Use hub
function git() {
	hub $*
	__EXECUTED_GIT_COMMAND=1
}

function plrq() {
  local save_git_editor=$GIT_EDITOR

  export GIT_EDITOR="$HOME/dotfiles/bin/plrq-editor"
  git pull-request $*
  GIT_EDITOR=$save_git_editor
}

# ghi -- github issues from command line
export GHI_TOKEN=`cat ~/private_files/ghi_token`

# Sugers
alias gs="git status --short --untracked-files"
alias gd="git diff --color"
alias gdc="git diff --color --cached"
alias gr="git reset"
alias grh~="git reset HEAD~"
alias grh\^="git reset 'HEAD^'"
alias gcam="git commit --amend"
alias gt="git tag"
alias grb="git rebase"
alias grbi="git rebase -i"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias gsl="git stash list"
alias gss="git stash save"
alias gsd="git stash show --color"
alias gsp="git stash pop"
alias gsdrop="git stash drop"
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

# Tig settings
TIG_LS_REMOTE="git ls-remote ."
