local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"

PROMPT='
%(?,,${return_status}[%?]%{$reset_color%} )%(1j.%{$fg[yellow]%}Job[%j]%{$reset_color%} .)%{$fg[green]%}[ ${PWD/#$HOME/~} ]%{$reset_color%} $(git_prompt_info)
%# '

function last_command() {
	echo `\history -1 | cut -d ' ' -f 3-20 | realiaser`
}
RPROMPT='%{$fg[$NCOLOR]%}%p $(last_command)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git: %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}[!]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}[?]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
