# Link dotfiles
DOTDIR=$HOME/dotfiles
dotfiles=(
	zshfiles/zshrc
	zshfiles/zshenv
	vimfiles/vim
	vimfiles/vimrc
	rubyfiles/pryrc
	gitfiles/git_template
	gitfiles/gitignore_global
	miscfiles/ctags
	miscfiles/latexmkrc
	miscfiles/tmux.conf
	miscfiles/vimperatorrc
	)

for f in $dotfiles
do
	basename=${f##*/}
	dotname=.$basename
	basefile=$DOTDIR/$f
	dotfile=$HOME/$dotname
	if [[ -L $dotfile ]]; then rm $dotfile; fi
	ln -s $basefile $dotfile
done

# Git submodule setup
git submodule init
git submodule update

# If you have problem with antigen about https connection
# sed -i 's/https/http/g' antigen.zsh
