function show_which() {
	prevcmd=`previous_command`
	echo "which:" `which ${prevcmd%% *}` "\n"
}
# preexec_functions+=(show_which)

function check_overcommit_installation() {
	if [ ! -d .git ]; then
		return
	fi

	if [ ! -L .git-hooks ]; then
		echo ""
		echo $fg[red] "Overcommit hooks is not deployed. Run: ln -s $HOME/dotfiles/gitfiles/overcommit_hooks .git-hooks"
	fi

	if [ ! -L .overcommit.yml ]; then
		echo ""
		echo $fg[red] "Overcommit configuration is not deployed. Run: ln -s $HOME/dotfiles/miscfiles/overcommit.yml .overcommit.yml"
	fi
}
precmd_functions+=(check_overcommit_installation)
