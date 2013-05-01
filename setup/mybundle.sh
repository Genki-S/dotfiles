mkdir -p $MYBUNDLES

# Install my bundles
command vim -u $DOTDIR/setup/mybundlerc -c "NeoBundleInstall" -c "quit"

bins=(
	js-beautify/python/js-beautify
	tidy-html5/bin/tidy
	)
if [[ $PLATFORM == "linux" ]]; then
	bins=(
		$bins
		peg-multimarkdown/multimarkdown
		peg-multimarkdown/scripts/*
	)
	# Use brew under mac
fi

for b in $bins
do
	basename=${b##*/}
	binname=${basename%%.*}
	basefile=$MYBUNDLES/$b
	binfile=$HOME/bin/$binname
	if [[ -L $binfile ]]; then rm $binfile; fi
	ln -s $basefile $binfile
done

