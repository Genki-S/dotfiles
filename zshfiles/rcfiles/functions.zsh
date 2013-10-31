function proxy () {
	export http_proxy="www-proxy.waseda.jp:8080"
	export https_proxy="www-proxy.waseda.jp:8080"
}

function noproxy () {
	http_proxy=
	https_proxy=
	ftp_proxy=
}

# Usage: cdup pattern
# search pattern for upper directories and cd to first matched directory
# e.g. cwd: /super/very/deep/directory -> `cdup ery` -> cwd: /super/very
function cdup () {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 pattern"
		return 1
	fi

	local pat=$1
	local cwd=${PWD%/*}
	while [ $cwd != '/' ] ; do
		local dirname=${cwd##*/}
		if [[ $dirname =~ $pat ]]; then
			cd $cwd
			return 0
		fi
		cwd=${cwd%/*}
	done
	return 1
}

# Usage: extract_line N
# extract line #n from standard input
# example: `find . -name 'foo' | extract_line 1
function extract_line()
{
	case $# in
		1)
			sed -n "${1}p";;
		2)
			sed -n "${1},${2}p";;
		*)
			;;
	esac
}

function xargs_with_alias()
{
	expanded_cmd=`expand_alias $1`
	shift
	expanded_cmd+=" $*"
	eval "xargs $expanded_cmd"
}
