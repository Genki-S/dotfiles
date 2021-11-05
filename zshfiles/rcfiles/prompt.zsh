# ref: `man zshmisc` EXPANSION OF PROMPT SEQUENCES

setopt PROMPT_SUBST
autoload -U colors && colors

# TODO: Consider if having zsh-git-prompt is worth the delay
#       If I don't use it, be sure to remove zsh-git-prompt from submodule
#source $HOME/dotfiles/submodules/zsh-git-prompt/zshrc.sh
#GIT_PROMPT_EXECUTABLE='haskell'

psvar=()
# keep track of psvar indices and contents here:
#   1: current value of $AWS_DEFAULT_REGION

update-aws-region-precmd() {
  psvar[1]="$(aws configure get region)"
  if [ -n "$AWS_DEFAULT_REGION" ]; then
    psvar[1]="$AWS_DEFAULT_REGION"
  fi
}

precmd_functions+=(update-aws-region-precmd)

# ref: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
() {
  local cmd_indicator='%{$fg_bold[red]%}$([ "$KEYMAP" = "vicmd" ] && echo "CMD")%{$reset_color%}'
  local return_status='%(?..%{$fg[red]%}%(?..✘)%{$reset_color%}[%?] )'
  local background_jobs='%(1j.%{$fg[yellow]%}Job[%j]%{$reset_color%} .)'
  local kube_context='(kube: $(kubectl config current-context 2> /dev/null)@$(kubectl config view --minify 2> /dev/null | grep namespace | sed "s/^ *namespace: //")) '
  local aws_region='%(1V.(aws: %1v) .)'
  local cwd='%{$fg[green]%}[ ${PWD/#$HOME/~} ]%{$reset_color%} '
  local user_host_time='%{$fg[magenta]%}%n%{$reset_color%} on %{$fg[yellow]%}%m%{$reset_color%} at %{$fg[white]%}%D %*%{$reset_color%}'
  #local git_status='$(git_super_status) '
  local git_status=''
  PROMPT="
${cmd_indicator}${return_status}${background_jobs}${cwd}${kube_context}${aws_region}${git_status}${user_host_time}
%# "
}
