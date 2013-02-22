# The following lines were added by compinstall
zstyle :compinstall filename '/home/genki/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# ==================================================
# Antigen
# ==================================================
source $HOME/dotfiles/zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen-lib

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen-bundle git
antigen-bundle command-not-found

# Syntax highlighting bundle.
antigen-bundle zsh-users/zsh-syntax-highlighting

# More completions
antigen-bundle zsh-users/zsh-completions src

# Easy history search
antigen-bundle zsh-users/zsh-history-substring-search
bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

# Directory specific environment segging
antigen-bundle kennethreitz/autoenv

# Load the theme.
source $MYBUNDLES/zsh-git-prompt/zshrc.sh
export __GIT_PROMPT_DIR=$MYBUNDLES/zsh-git-prompt
__EXECUTED_GIT_COMMAND=1 # To force prompt update at first
antigen-theme $HOME/dotfiles/genki.zsh-theme

# Tell antigen that you're done.
antigen-apply

# ==================================================
# My zsh
# ==================================================
# Load all config files
if ls $HOME/dotfiles/zsh/zshrc/common/**/*.zsh &> /dev/null; then
	for config_file ($HOME/dotfiles/zsh/zshrc/common/**/*.zsh) source $config_file
fi
if ls $HOME/dotfiles/zsh/zshrc/$PLATFORM/**/*.zsh &> /dev/null; then
	for config_file ($HOME/dotfiles/zsh/zshrc/$PLATFORM/**/*.zsh) source $config_file
fi

# ==================================================
# My bundles
# ==================================================

# dircolors-solarized
eval `dircolors $MYBUNDLES/dircolors-solarized/dircolors.256dark`

# ==================================================
# Miscellaneous
# ==================================================
# RescueTime
ps -e | grep rescuetime &> /dev/null
if [ $? -ne 0 ]; then
	if which rescuetime &> /dev/null; then
		screen -d -m rescuetime
	else
		echo "You should install RescueTime, really."
	fi
fi

# Realiaser
alias > $HOME/.alias.cache

# ==================================================
# Tmux
# ==================================================
function tmuxpwd() {
	if [ -n "$TMUX" ]; then
		tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD"
	fi
}
precmd_functions=($precmd_functions tmuxpwd)

# Tmuxinator
which tmuxinator &> /dev/null
if [ $? -ne 0 ]; then
	echo "Just run \"gem install tmuxinator\""
fi
[ -s $HOME/.tmuxinator/scripts/tmuxinator ] && source $HOME/.tmuxinator/scripts/tmuxinator

# ==================================================
# Welcome Message
# ==================================================
uname -a
cat <<HEREDOC
  _____                                   __  ___   ___ _   __  
 |  __ \                                 /_ |/ _ \ / _ (_) / /  
 | |  | | ___    _   _  ___  _   _ _ __   | | | | | | | | / /   
 | |  | |/ _ \  | | | |/ _ \| | | | '__|  | | | | | | | |/ /    
 | |__| | (_) | | |_| | (_) | |_| | |     | | |_| | |_| / / _ _ 
 |_____/ \___/   \__, |\___/ \__,_|_|     |_|\___/ \___/_/ (_|_)
                  __/ |                                         
                 |___/                                          
HEREDOC

# Random reminders
echo
echo "=== Random Reminder ==="
shuf -n 1 ~/random_reminders.txt

# Oblique Strategies
echo
echo "=== Oblique Strategy ==="
shuf -n 1 ~/oblique_strategies.txt

# Tmuxinator project list
if [ -z "$TMUX" ]; then
	echo
	echo "=== My Projects ==="
	mux list
fi
