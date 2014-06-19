if is_mac; then
	path=(
		# Brew bin prevails
		/usr/local/bin
		# Python bin
		/usr/local/share/python
		# Go bin
		$GOPATH/bin
		$path
	)
fi
