# Source rbenv environment
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Tell bundler to use local Gemfile
function set_bundle_gemfile () {
	if [[ -f Gemfile.local ]]; then
		export BUNDLE_GEMFILE=$PWD/Gemfile.local
	else
		unset BUNDLE_GEMFILE
	fi
}
preexec_functions+=(set_bundle_gemfile)
