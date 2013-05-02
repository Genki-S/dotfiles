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

function previous_command() {
	echo `cat \`readlink -f $HISTFILE\` | tail -n1 | sed 's/[^;]*;//'`
}

# Usage: full_command cmd arg whatever
function full_command() {
	com=$*
	separator=(';' '|' '&&' '||')
	for sep in $separator
	do
		com=`echo $com | sed "s/${(q)sep}/ ${(q)sep} /g"`
	done
	com=`echo $com | sed "s/  */ /g" | sed "s/\| \|/\|\|/g"`
	comarr=(${(s/ /)com})
	bin=true
	for (( i = 1; i <= ${#comarr}; i++ )) do
		if [[ ${comarr[i]} =~ ${(j/|/)${(q)separator}} ]]; then
			bin=true
			continue
		fi
		if [[ $bin != "true" ]]; then
			continue
		fi
		wh=`which "${comarr[i]}"`
		if [[ $wh =~ ".*not found.*" ]]; then
		elif [[ $wh =~ ".*aliased to.*" ]]; then
			# Wrap alias with double quote (TODO: deal with recursive alias)
			comarr[$i]=`echo $wh | sed "s/.*aliased to \(.*\)/\"\1\"/"`
		elif [[ $wh =~ ".*shell built-in command.*" ]]; then
			comarr[$i]=`echo $wh | sed "s/^\([^:]*\):.*/\1/"`
		else
			comarr[$i]=$wh
		fi
		bin=false
	done
	echo $comarr
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
