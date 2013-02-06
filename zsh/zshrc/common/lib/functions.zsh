function noproxy () {
	http_proxy=
	https_proxy=
	ftp_proxy=
}

function lighten () {
	PROMPT='
%# '
	RPROMPT=''
}

function mkcd () {
	mkdir -p "$@" && eval cd "\"\$$#\""
}
