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

function zman() {
	PAGER="less -g -s '+/^       "$1"'" man zshall
}

function aoj() {
	clicoder new aoj $1
	dir=$(printf "%04d" $1)
	cd $dir
}

# http://qiita.com/dai___chi/items/b71fe99339bdbe5b5347
function pbsearch() {
	clipMenuPath="$HOME/Library/Application Support/ClipMenu"
	plutil -convert xml1 $clipMenuPath/clips.data -o - \
		| awk '/<string>/,/<\/string>/' \
		| awk 1 ORS='<BR>' \
		| sed -e "s/<string>//g" -e 's/<\/string><BR>/\
/g' \
		| tail -n +15 \
		| sed '/^$/d'| cat -n | sort -k 2| uniq -f1 | sort -k 1 \
		| sed -e 's/^ *[0-9]*//g' \
		| sed -e 's/^\s*//g' \
		| peco \
		| sed -e 's/<BR>/\
/g' \
		| sed -e 's/&lt;/</g' -e 's/&gt;/>/g' \
		| reattach-to-user-namespace pbcopy
	reattach-to-user-namespace pbpaste
};
