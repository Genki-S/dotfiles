# aliases {{{
alias g='git'
alias ga='git add'
alias gs='git status --branch --show-stash --untracked-files --renames'
alias gco='git checkout'
alias gcm='git checkout master'
alias gd='git diff --color'
alias gdc='git diff --color --cached'
alias gp='git push'
alias gl='git pull --rebase'
alias gm='git merge'
alias gmt='git mergetool'
alias gr='git reset'
alias grh='git reset HEAD'
alias gc='git commit'
alias gcam='git commit --amend --no-edit'
alias gcame='git commit --amend'
alias gt='git tag'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbim='git rebase -i master'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grba='git rebase --abort'
alias gsl='git stash list'
alias gss='git stash save --include-untracked'
alias gsd='git stash show --color' # d for diff
alias gsp='git stash pop --index'
alias gsdrop='git stash drop'

# tig
alias tigb='tig master..HEAD' # see branch commits
# }}}

# vim:foldmethod=marker
