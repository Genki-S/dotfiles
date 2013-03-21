# Git submodule setup
git submodule init
git submodule update

# If you have problem with antigen about https connection
# sed -i 's/https/http/g' antigen.zsh

# Source setups
for f in $HOME/dotfiles/setup/*.sh
do
	source $f
done
