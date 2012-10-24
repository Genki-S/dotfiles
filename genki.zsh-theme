local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"

PROMPT='
%(?,,${return_status}[%?]%{$reset_color%} )%(1j.%{$fg[yellow]%}Job[%j]%{$reset_color%} .)%{$fg[green]%}[ ${PWD/#$HOME/~} ]%{$reset_color%} $(git_prompt_info)
%# '
RPROMPT='%T'

ZSH_THEME_GIT_PROMPT_PREFIX="git: %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}[!]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}[?]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
