function echoerr() { echo "$@" 1>&2 }

function expand_alias() {
	if (( $# != 1 )); then
		echoerr "Usage: expand_alias CMD"
		return 1
	fi
	alias $1 > /dev/null
	if (( $? != 0 )); then
		echo $1
		return 0
	fi
	alias=`alias $1 | sed -e "s/[^=]*='\{0,1\}\([^']*\)'\{0,1\}/\1/"`
	echo $alias
}

function initializer_trigger() {
	if (( $? != 0 )); then
		# Previous command did not succeed
		return 1
	fi
	prevline=`cat \`readlink -f $HISTFILE\` | tail -n1`
	prevline=${prevline##*;}
	prevcmd=${prevline%% *}
	if [[ $prevline =~ '[^ ]* [^ ][^ ]*' ]]; then
		prevarg=${prevline#* }
	else
		prevarg=""
	fi
	prevline="`expand_alias $prevcmd` $prevarg"
	if [[ $prevline =~ "git init" ]]; then
		initializer git
	elif [[ $prevline =~ "rails new" ]]; then
		appname=${prevline##rails new }
		appname=${appname%% *}
		pushd $appname
		initializer rails
		popd
	fi
}

function initializer() {
	if (( $# == 0 )); then
		echoerr "Usage: initializer NAME"
		return 1
	fi
	script=~/dotfiles/finetune/$1/initializer.sh
	echo "Initialize $1 with my preferences."
	echo "Sourcing $script ..."
	source $script
}
