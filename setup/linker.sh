#!/bin/bash

# ==================================================
# My bundles
# ==================================================
function symlink_bundle {
	local src=$1
	local dst=$HOME/bin/${1##*/} # trim directory(ies)
	dst=${dst%%.*} # trim extension(s)
	if [ -L $dst ]; then
		rm -f $dst
	fi
	echo "ln -s $src $dst"
	ln -s $src $dst
}

symlink_bundle $MYBUNDLES/js-beautify/python/js-beautify
symlink_bundle $MYBUNDLES/tidy-html5/bin/tidy

PEG=$MYBUNDLES/peg-multimarkdown
for f in $PEG/multimarkdown $PEG/scripts/*
do
	symlink_bundle $f
done
