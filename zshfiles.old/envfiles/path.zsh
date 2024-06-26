if is_mac; then
	path=(
		# Brew bin prevails
		/usr/local/bin
		# Python bin
		/usr/local/share/python
		# Go bin
		$GOPATH/bin
		# npm bin
		$HOME/dotfiles/node_modules/.bin
		# anaconda
		$HOME/anaconda3/bin
		# Cargo
		$HOME/.cargo/bin
		$path
	)
else
	path=(
		# Go bin
		$GOPATH/bin
		# npm bin
		$HOME/dotfiles/node_modules/.bin
		# Cargo
		$HOME/.cargo/bin
		$path
	)
fi
