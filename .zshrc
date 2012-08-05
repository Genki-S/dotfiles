# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/genki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# PATH setting
# Add: path to texlive
export PATH=$PATH:/usr/local/texlive/2011/bin/i386-linux/

# Linux 101 Hacks
alias cd1="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
# cd -
# dirs, pushd, popd
# shopt -s cdspell (not for zsh)

# Linux 101 Hacks End

export HTTP_HOME=http://vim.wikia.com/wiki/Special:Random
