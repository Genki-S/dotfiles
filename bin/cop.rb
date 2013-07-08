#!/usr/bin/env ruby

require 'fileutils'

# Configuration
rules = [
  {
    name: 'my_must_rule',
    file: "#{ENV['HOME']}/dotfiles/rubyfiles/cops/must.yml",
    must: true
  },
  {
    name: 'my_should_rule',
    file: "#{ENV['HOME']}/dotfiles/rubyfiles/cops/should.yml",
    must: false
  }
]

git_root = `git rev-parse --show-toplevel`.chomp
Dir.chdir(git_root)

output_dir = '.patrol'
FileUtils.rm_rf(output_dir)
FileUtils.mkdir(output_dir)
puts "All rubocop output will be written into #{output_dir}"

files_to_be_committed = `git diff HEAD --cached --name-only`.split
ruby_files_to_be_committed = []
files_to_be_committed.each do |f|
  ruby_files_to_be_committed << f if File.file?(f) && f =~ /\.rb$/
end

# Check rules
offenses = { must: [], should: [] }
rules.each do |rule|
  ruby_files_to_be_committed.each do |f|
    output = "#{output_dir}/#{f.gsub('/', '-+-')}_#{rule[:name]}"
    system("rubocop --config #{rule[:file]} --out #{output} #{f}")
    if $?.success?
      FileUtils.rm(output)
    else
      offenses[:must] << { file: f, output: output } if rule[:must]
      offenses[:should] << { file: f, output: output } unless rule[:must]
    end
  end
end

# Result
if offenses[:must].any?
  $stderr.puts('[error] These "must" offenses are detected.')
  offenses[:must].each do |of|
    $stderr.puts File.read(of[:output])
  end
  abort
end

if offenses[:should].any?
  $stderr.puts('[warning] These "should" offenses are detected.')
  offenses[:should].each do |of|
    $stderr.puts File.read(of[:output])
  end
  $stderr.puts('You might want to fix it before commit.')
end

exit
