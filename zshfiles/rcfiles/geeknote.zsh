alias geeknote="python $MYBUNDLES/geeknote/geeknote.py"
alias gn="geeknote"
alias gnc="gn create"
alias gne="gn edit"
alias gnf="gn find"
alias gns="gn show"
alias gnrm="gn remove"
alias gnbls="gn notebook-list"
alias gnbc="gn notebook-create"
alias gnbe="gn notebook-edit"
alias gntls="gn tag-list"
alias gntc="gn tag-create"
alias gnte="gn tag-edit"

alias gnsync="python $MYBUNDLES/geeknote/gnsync.py"

# Journaling function
function jl() {
	echo -n "Title: "
	read title
	echo -n "Tags(space separated): "
	read tags
	geeknote create --title $title --content "WRITE" --tags $tags --notebook Journal
}

# Stash my idea
function spark() {
	echo -n "Tags(space separated): "
	read tags
	geeknote create --title "spark on `date`" --content "$*" --tags $tags --notebook "The Spark File"
}

# GTD collection
function gni() {
	geeknote create --title "$*" --content ""
}
