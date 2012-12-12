# The following lines were added by compinstall
zstyle :compinstall filename '/home/genki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# TODO: This will be sourced again below...
source $HOME/dotfiles/zsh/lib/env.zsh

# ==================================================
# oh-my-zsh
# ==================================================
# Path to your oh-my-zsh configuration.
export ZSH=$MYBUNDLES/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="genki"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ==================================================
# My zsh
# ==================================================
# Load all of the config files in zsh/lib that end in .zsh
for config_file ($HOME/dotfiles/zsh/lib/*.zsh) source $config_file

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

# auto launch
ps -e | grep tmux &> /dev/null
if [ $? -ne 0 ]; then
	if which tmux &> /dev/null; then
		tmux
	else
		echo "tmux not installed. pity..."
	fi
fi

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
shuf -n 1 ~/random_reminders.txt
