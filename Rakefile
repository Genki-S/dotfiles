require 'rake'
require 'fileutils'
require 'yaml'
require 'uri'

HOME = ENV['HOME']
DOTDIR = "#{HOME}/dotfiles"

desc 'Do the best.'
task :install => [
  :install_homebrew,
  :install_ruby,
  :init_submodules,
  :update_submodules,
  :update_injection,
  :brew_essentials,
  :orgmode,
  :deploy,
  :chsh ] do
  my_ln("#{DOTDIR}/macfiles/Library/Application\\ Support/Karabiner/private.xml", "#{HOME}/Library/Application\\ Support/Karabiner/private.xml")
  puts 'run `rake bundle_up` after logging in with zsh'
end

desc 'Do the best for unix.'
task :install_unix => [
  :init_submodules,
  :update_submodules,
  :update_injection,
  :orgmode,
  :deploy,
  :chsh ] do
  puts 'run `rake bundle_up_unix` after logging in with zsh'
end

desc 'Install softwares'
task :bundle_up => [
  :brew_optionals,
  :go_get,
  :cargo_install,
  :ghq_get,
  :npm_install,
  :bundle_install,
  :install_rbenv_plugins,
  :setup_osx] do
end

desc 'Install softwares'
task :bundle_up_unix => [
  :go_get,
  :cargo_install,
  :ghq_get,
  :npm_install,
  :bundle_install,
  :install_rbenv_plugins] do
end

desc 'Change login shell'
task :chsh do
  puts 'Changing login shell...'
  shell = '/usr/local/bin/zsh'
  run %{
    grep #{shell} /etc/shells > /dev/null || echo #{shell} | sudo tee -a /etc/shells > /dev/null
  }
  run %{ chsh -s #{shell} }
end

desc 'install homebrew'
task :install_homebrew do
  puts 'Installing Homebrew...'
  run %{ which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" }
  run %{ brew doctor }
end

desc 'install essential brew packages'
task :brew_essentials do
  run %{ brew tap Homebrew/bundle }
  run %{ brew bundle --file=Brewfile }
end

desc 'install optional brew packages'
task :brew_optionals do
  run %{ brew bundle --file=Brewfile.optional }
end

desc 'setup osx'
task :setup_osx do
  run %{ ./setup/setup_osx }
end


desc 'install ruby'
task :install_ruby do
  puts 'Installing Ruby...'
  run %{ brew install rbenv ruby-build }
  run %{ rbenv install 2.1.3 } # TODO: ask version to user
  run %{ rbenv rehash }
  run %{ rbenv global 2.1.3 }
end

desc 'Deploy dotfiles and other files.'
task :deploy do
  directories = YAML.load_file('config/directory_structure.yml')
  dotfiles = YAML.load_file('config/dotfiles.yml')
  Dir.chdir(HOME) do
    mkdir_hierarchy(directories)
  end
  Dir.chdir(DOTDIR) do
    deploy_dotfiles(dotfiles)
  end

  # TODO: Do this better ($HOME/.config is becoming the standard recently)
  my_ln("#{DOTDIR}/miscfiles/get-shit-done.ini", "#{HOME}/.config/get-shit-done.ini")
  my_ln("#{DOTDIR}/miscfiles/dunstrc", "#{HOME}/.config/dunst/dunstrc")
  my_ln("#{DOTDIR}/nvim", "#{HOME}/.config/nvim")
  my_ln("#{DOTDIR}/miscfiles/compton", "#{HOME}/.config/compton")
end

desc 'Update submodules'
task :update_submodules do
  run %{
    git submodule update --recursive
  }
  # neobundle is treated specially (to manage itself via neobundle)
  unless File.directory?("#{DOTDIR}/vimfiles/vim/bundles/neobundle.vim")
    run %{ git clone https://github.com/Shougo/neobundle.vim vimfiles/vim/bundles/neobundle.vim }
  end
end

task :init_submodules do
  run %{ git submodule update --init --recursive }
end

desc 'Prepare Orgmode'
task :orgmode do
  my_ln("#{HOME}/Dropbox/org", "#{HOME}/org")
end

desc 'Prepare Go packages'
task :go_get do
  # There must be a better way, but it works
  File.read("#{DOTDIR}/Gofile").each_line do |gocmd|
    run %{ go #{gocmd} }
  end
end

desc 'Prepare Rust packages'
task :cargo_install do
  # There must be a better way, but it works
  File.read("#{DOTDIR}/Cargofile").each_line do |cargocmd|
    run %{ cargo #{cargocmd} }
  end
end

desc 'Clone repositories'
task :ghq_get do
  repos = YAML.load_file("#{DOTDIR}/config/ghq.yml")
  repos.each do |repo|
    run %{ ghq get #{repo} }
  end
end

desc 'Install npm packages'
task :npm_install do
  Dir.chdir(DOTDIR) do
    run %{ npm install }
  end
end

desc 'Install ruby gems'
task :bundle_install do
  Dir.chdir(DOTDIR) do
    run %{ ./setup/install-rbenv-plugins.sh }
  end
end

desc 'Install rbenv plugins'
task :install_rbenv_plugins do
  if ENV['RBENV_ROOT'].to_s.empty?
    warn '$RBENV_ROOT is not defined'
    return
  end
  run %{ #{DOTDIR}/setup/install-rbenv-plugins.sh }
end

desc 'Generate ctags files for ghq repositories'
task :ghq_ctags do
  repos = YAML.load_file("#{DOTDIR}/config/ghq.yml")
  repos.each do |repo|
    run %{ cd `ghq list -e -p #{repo}` && ctags -R . }
  end
end

desc 'Generate dictionary files (for vim completion) for ghq repositories'
task :ghq_dict do
  repos = YAML.load_file("#{DOTDIR}/config/ghq.yml")
  repos.each do |repo|
    run %{ cd `ghq list -e -p #{repo}` && cat tags | cut -f1 | uniq > tags.dict }
  end
end

# FIXME: use $RBENV_ROOT
desc 'Generate dictionary files (for vim completion) for ruby'
task :ruby_dict do
  # Ref: http://henry.animeo.jp/blog/2013/08/24/ruby-dict/
  # Assumes rbenv is used.
  # Creates ~/.rbenv/versions/*/ruby.dict
  Dir.glob("#{HOME}/.rbenv/versions/*").each do |ruby_dir|
    Dir.chdir(ruby_dir) do
      methods = []
      Dir.glob("#{Dir.pwd}/**/*.ri").each do |file|
        method = URI.decode(File.basename(file))
        if /^(.*)-\w*\.ri$/ =~ method
          methods << $1
        end
      end

      File.open('ruby.dict', 'w') do |file|
        file.write(methods.uniq.sort.join("\n"))
      end
    end
  end
end

desc 'Update files with injection of other files'
task :update_injection do
  files_with_injection = run %{
    ag --files-with-matches 'INJECT_START' --ignore 'Rakefile' --ignore 'bin/inject'
  }
  files_with_injection.split.each do |fname|
    run %{ #{DOTDIR}/bin/inject #{fname} }
  end
end

desc 'Mac settings'
task :mac do
  puts "Deploying plist files"
  Dir.glob("#{DOTDIR}/macfiles/LaunchAgents/*") do |plist|
    fname = File.basename(plist)
    my_ln(plist, "#{HOME}/Library/LaunchAgents/#{fname}")
  end
  Dir.glob("#{DOTDIR}/macfiles/LaunchDaemons/*") do |plist|
    fname = File.basename(plist)
    my_ln(plist, "/Library/LaunchDaemons/#{fname}", true)
  end
end

task :generate_global_tags do
  run %{
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
  }
end

private

def run(cmd)
  puts "[Running] #{cmd} (#{Dir.pwd})"
  ret = `#{cmd}` unless ENV['DEBUG']
  raise $?.to_s unless $?.success?
  ret
end

def mkdir_hierarchy(obj)
  case obj
  when String
    run %{ mkdir -p #{obj} }
  when Array
    obj.each{ |o| mkdir_hierarchy(o) }
  when Hash
    obj.each do |k, v|
      run %{ mkdir -p #{k} }
      Dir.chdir(k) do
        mkdir_hierarchy(v)
      end
    end
  end
end

def deploy_dotfiles(obj)
  case obj
  when String
    my_ln("#{Dir.pwd}/#{obj}", "#{HOME}/.#{obj}")
  when Array
    obj.each{ |o| deploy_dotfiles(o) }
  when Hash
    obj.each do |k, v|
      Dir.chdir(k) do
        deploy_dotfiles(v)
      end
    end
  end
end

def my_ln(src, dst, sudo = false)
  run %{ rm #{dst} } if File.symlink?(dst)
  raise %{File "#{dst}" exists and not a symlink.} if File.exists?(dst)
  dir = File.dirname(dst)
  FileUtils.mkdir_p(dir) unless File.directory?(dir)
  run %{ #{sudo ? 'sudo' : ''} ln -s #{src} #{dst} }
end

def warn(msg)
  STDERR.puts msg
end

# OS check (http://stackoverflow.com/questions/170956/how-can-i-find-which-operating-system-my-ruby-program-is-running-on)
module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end
