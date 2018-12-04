# ref: `man zshmisc` EXPANSION OF PROMPT SEQUENCES

setopt PROMPT_SUBST
autoload -U colors && colors

# TODO: Consider if having zsh-git-prompt is worth the delay
#       If I don't use it, be sure to remove zsh-git-prompt from submodule
#source $DOTDIR/submodules/zsh-git-prompt/zshrc.sh
#GIT_PROMPT_EXECUTABLE='haskell'

() {
  local return_status='%(?..%{$fg[red]%}%(?..✘)%{$reset_color%}[%?] )'
  local background_jobs='%(1j.%{$fg[yellow]%}Job[%j]%{$reset_color%} .)'
  local kube_context='(kube: $(kubectl config current-context 2> /dev/null)) '
  local cwd='%{$fg[green]%}[ ${PWD/#$HOME/~} ]%{$reset_color%} '
  local user_host_time='%{$fg[magenta]%}%n%{$reset_color%} on %{$fg[yellow]%}%m%{$reset_color%} at %{$fg[white]%}%D %*%{$reset_color%}'
  #local git_status='$(git_super_status) '
  local git_status=''
  PROMPT="
${return_status}${background_jobs}${cwd}${kube_context}${git_status}${user_host_time}
%# "
}

