setopt auto_pushd

DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs

if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
	dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
	[[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi

function store_dirstack() {
	print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

chpwd_functions+=(store_dirstack)
