if [[ $PLATFORM == "mac" ]]; then
	path=(
		# Brew bin prevails
		/usr/local/bin
		$path
	)
fi

