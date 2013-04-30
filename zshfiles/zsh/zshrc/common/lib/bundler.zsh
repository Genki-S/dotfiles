set_bundle_gemfile () {
	if [[ -f Gemfile.local ]]; then
		export BUNDLE_GEMFILE=Gemfile.local
	else
		unset BUNDLE_GEMFILE
	fi
}

preexec_functions+=(set_bundle_gemfile)
