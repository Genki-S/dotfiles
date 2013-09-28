require 'rake'
require 'fileutils'

# HOME = ENV['HOME']
# DOTDIR = "#{HOME}/dotfiles"
HOME = "#{ENV['HOME']}/tmphome"
DOTDIR = "#{ENV['HOME']}/dotfiles"

desc 'Deploy dotfiles.'
task :deploy do
  directories = YAML.load_file('config/directory_structure.yml')
  dotfiles = YAML.load_file('config/dotfiles.yml')
  Dir.chdir(HOME) do
    mkdir_hierarchy(directories)
  end
  Dir.chdir(DOTDIR) do
    deploy_dotfiles(dotfiles)
    safe_ln "#{DOTDIR}/gitfiles/hooks" "#{DOTDIR}/gitfiles/git_template/hooks"
  end
end

private

def run(cmd)
  puts "[Running] #{cmd} (#{Dir.pwd})"
  `#{cmd}` unless ENV['DEBUG']
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
    safe_ln("#{Dir.pwd}/#{obj}", "#{HOME}/.#{obj}")
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

def safe_ln(src, dst)
  run %{ rm #{dst} } if File.symlink?(dst)
  raise %{File "#{dst}" exists and not a symlink.} if File.exists?(dst)
  run %{ ln -s #{src} #{dst} }
end
