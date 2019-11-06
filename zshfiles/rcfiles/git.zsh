# aliases {{{
alias g='git'
alias ga='git add'
alias gs='git status --branch --show-stash --untracked-files --renames'
alias gco='git checkout'
alias gcm='git checkout master'
alias gd='git diff --color --ignore-all-space'
alias gdc='git diff --color --ignore-all-space --cached'
alias gf='git fetch'
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

# Stolen from oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh/blob/97c03841691021f916c46b2fd2d089d7970400aa/lib/git.zsh#L61-L74
function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

# vim:foldmethod=marker
