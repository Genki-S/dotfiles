# Its' aliased to git automatically (when using boxen?)
# but unalias it because I wanna set __EXECUTED_GIT_COMMAND
alias git >/dev/null 2>&1 && unalias git

# Use hub
function git() {
  hub $*
  __EXECUTED_GIT_COMMAND=1
}

alias git-root="git rev-parse --show-toplevel"

function preq() {
  local save_git_editor=$GIT_EDITOR

  export GIT_EDITOR="$HOME/dotfiles/bin/preq-editor"
  git pull-request $* --browse
  GIT_EDITOR=$save_git_editor
  if [[ -z $GIT_EDITOR ]]; then
    unset GIT_EDITOR
  fi
}

# ghq
# http://weblog.bulknews.net/post/89635306479/ghq-peco-percol
alias gcd='cd $(ghq list --full-path | peco)'

# Sugers
alias gs="git status --short --untracked-files"
# git status files
alias gsf="git status --short --untracked-files | awk '{ print \$2 }'"
alias gd="git diff --color"
alias gdc="git diff --color --cached"
alias gl="git pull --rebase"
alias gm="git merge"
alias gmt="git mergetool"
alias gr="git reset"
alias grh~="git reset HEAD~"
alias grh\^="git reset 'HEAD^'"
alias gcam="git commit --amend --no-edit"
alias gcame="git commit --amend"
alias gt="git tag"
alias grb="git rebase"
alias grbm="git rebase master"
alias grbi="git rebase -i"
alias grbim="git rebase -i master"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias gsl="git stash list"
alias gss="git stash save --include-untracked"
alias gsd="git stash show"
alias gsdiff="git stash show --color"
alias gsp="git stash pop --index"
alias gsdrop="git stash drop"
alias gbws='git browse $(ghq list | sed "s!github\.com/!!" | peco)'
# Get sha with e.g. `$ grp HEAD`
alias grp="git rev-parse --verify"
function gbw() {
  root=$(git-root)
  if [ -z "$root" ]; then
    gbws
  else
    git browse
  fi
}
# git branch select
alias gbs="git branch -a | peco | xargs git checkout"
# list things
function gls() {
  if [[ $# -eq 0 ]]; then
    return
  fi
  case "$1" in
    untracked)
      git ls-files --other --exclude-standard
      ;;
    *)
      ;;
  esac
}
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
alias tigb="tig master..HEAD" # see branch commits
TIG_LS_REMOTE="git ls-remote ."

# Helper functions
function git-myinit() {
  git flow init
  git hooks --install
}

function delete_local_merged_branches() {
  git branch --merged master | grep -v master | xargs git branch -d
}

function delete_remote_merged_branches() {
  git fetch origin
  git remote prune origin

  for BRANCH in `git branch -r --merged origin/master |\
                 egrep "^\s*origin/"                  |\
                 grep -v master                       |\
                 grep chrishunt                       |\
                 cut -d/ -f2-`
  do
    git push origin :$BRANCH
  done
}

function weekly_summary() {
  LAST_WEEK=$(date -v-7d +%m/%d)

  STATS=$(
    git log --since=1.week --oneline |
    tail -n 1                        |
    awk '{ print $1 }'               |
    xargs git diff --shortstat
  )

  FEATURES=$(
    git log --since=1.week --oneline |
    egrep "Merge (pull|branch) "
  )

  FEATURES_COUNT=$(
    echo "$FEATURES" |
    sed '/^\s*$/d'   |
    wc -l            |
    awk '{ print $1 }'
  )

  echo "Stats ($LAST_WEEK - Today)"
  echo "---------------------"
  echo "$STATS"
  echo
  echo "Features ($FEATURES_COUNT)"
  echo "-------------"
  echo "$FEATURES"
}
