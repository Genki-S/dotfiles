local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"

PROMPT='
%(?,,${return_status}[%?]%{$reset_color%} )%(1j.%{$fg[yellow]%}Job[%j]%{$reset_color%} .)%{$fg[green]%}[ ${PWD/#$HOME/~} ]%{$reset_color%} $(git_super_status) %{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%}
%# '

# Dirty fix for ambiwidth characters (just adding single space)
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}● "
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}✚ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="… "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ "
