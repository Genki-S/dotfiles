git config --global user.name "Genki"
git config --global user.email cfhoyuk.reccos.nelg@gmail.com

git config --global init.templatedir '~/.git_template'
git config --global core.excludesfile '~/.gitignore_global'

git config --global filter.rails_genki_env.smudge \
	"sed 's/Bundler.require(\*Rails.groups(:assets => %w(development test)))/Bundler.require(*Rails.groups(:assets => %w(development test genki)))/'"
git config --global filter.rails_genki_env.clean \
	"sed 's/Bundler.require(\*Rails.groups(:assets => %w(development test genki)))/Bundler.require(*Rails.groups(:assets => %w(development test)))/'"
