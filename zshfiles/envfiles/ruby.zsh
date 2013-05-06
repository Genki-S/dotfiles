# Source rvm environment
which rails &> /dev/null
if [ $? -ne 0 ]; then
	source $HOME/.rvm/environments/default
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Tell bundler to use local Gemfile
function set_bundle_gemfile () {
	if [[ -f Gemfile.local ]]; then
		export BUNDLE_GEMFILE=Gemfile.local
	else
		unset BUNDLE_GEMFILE
	fi
}
preexec_functions+=(set_bundle_gemfile)
