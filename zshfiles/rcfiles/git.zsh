# Use hub
alias git=hub
if type compdef >/dev/null; then
	compdef hub=git
fi

# Sugers
alias gf="git diff --color"
alias gr="git reset"
alias grh~="git reset HEAD~"
alias grh\^="git reset 'HEAD^'"
alias gcam="git commit --amend"
