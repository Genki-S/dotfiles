ctags \
	-R \
	-f ~/tags_ruby \
	--sort=yes \
	--exclude=*.js \
	--exclude=*.h \
	--exclude=log \
	--exclude=*.yml \
	--exclude=.git \
	--langmap=RUBY:.rb \
	$rvm_path/rubies/default

ctags \
	-R \
	-f ~/tags_gem \
	--sort=yes \
	--exclude=*.js \
	--exclude=*.exp \
	--exclude=*.am \
	--exclude=*.in \
	--exclude=*.m4 \
	--exclude=*.o \
	--exclude=*.h \
	--exclude=log \
	--exclude=*.yml \
	--exclude=.git \
	--langmap=RUBY:.rb \
	$GEM_HOME/gems
