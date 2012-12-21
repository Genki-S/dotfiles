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
antigen-theme $HOME/dotfiles/genki.zsh-theme

# Tell antigen that you're done.
antigen-apply

# ==================================================
# My zsh
# ==================================================
# Load all of the config files in zsh/lib that end in .zsh
for config_file ($HOME/dotfiles/zsh/zshrc/lib/*.zsh) source $config_file

# ==================================================
# My bundles
# ==================================================

# dircolors-solarized
eval `dircolors $MYBUNDLES/dircolors-solarized/dircolors.256dark`


# Source rvm environment
which rails &> /dev/null
if [ $? -ne 0 ]; then
	source $HOME/.rvm/environments/default
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

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

# PomodoroApp
ps -e | grep tmux &> /dev/null
if [ $? -ne 0 ]; then
	if [ -x ~/PomodoroApp/PomodoroApp ]; then
		if [ ! -L ~/.local/share/data/PomodoroApp/PomodoroApp.db ]; then
			echo "You want to share PomodoroApp.db with Dropbox or something."
		else
			ps -e | grep PomodoroApp &> /dev/null
			if [ $? -ne 0 ]; then
				echo -n "Invoke PomodoroApp? [y/n]: "
				read CONFIRM
				case $CONFIRM in
					y|Y|YES|yes|Yes) screen -d -m ~/PomodoroApp/PomodoroApp ;;
					*)
				esac
			fi
		fi
	else
		echo "You should install PomodoroApp, really."
	fi
fi

# AutoJump
if [ -f /usr/share/autojump/autojump.zsh ]; then
	source /usr/share/autojump/autojump.zsh
else
	echo "You should install autojump, really."
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

# Tmuxinator project list
echo
echo "=== My Projects ==="
mux list
