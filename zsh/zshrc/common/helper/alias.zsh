function expand_alias()
{
	if (( $# != 1 )); then
		echoerr "Usage: expand_alias CMD"
		return 1
	fi
	alias $1 > /dev/null
	if (( $? != 0 )); then
		echo $1
		return 0
	fi
	alias=`alias $1`
	alias=`echo $alias | sed -e "s/[^=]*='\{0,1\}\([^']*\)'\{0,1\}/\1/"`
	echo $alias
}
