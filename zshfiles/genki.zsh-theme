# `man zshmisc` EXPANSION OF PROMPT SEQUENCES

local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"

kube_context() {
  echo "(kube: $(kubectl config current-context 2> /dev/null))"
}

PROMPT='
%{$fg_bold[red]%}$(zvim_is_command_mode && echo "CMD")%{$reset_color%}%(?..${return_status}[%?]%{$reset_color%} )%(1j.%{$fg[yellow]%}Job[%j]%{$reset_color%} .)%{$fg[green]%}[ ${PWD/#$HOME/~} ]%{$reset_color%} $(kube_context) $(git_super_status) %{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} at %{$fg[white]%}%D %*%{$reset_color%}
%# '

# RPROMPT
# TODO: remove magic string "CURRENT TIME"
RPROMPT='CURRENT TIME: %*'

# Dirty fix for ambiwidth characters (just adding single space)
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}● %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}✖ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}✚ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="… "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_CACHE=1
