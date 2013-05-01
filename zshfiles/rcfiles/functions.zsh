function proxy () {
	export http_proxy="www-proxy.waseda.jp:8080"
	export https_proxy="www-proxy.waseda.jp:8080"
}

function noproxy () {
	http_proxy=
	https_proxy=
	ftp_proxy=
}

function mkcd () {
	mkdir -p "$@" && eval cd "\"\$$#\""
}
