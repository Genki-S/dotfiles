require 'set'

module Overcommit::Hook::PreCommit
  class GolangciLint < Base
    def run
      packages = Set.new()
      applicable_files.each do |filename|
        dirname = File.dirname(filename)
        packages.add(dirname)
      end

      result = execute(command, args: ['run', '--enable-all', '--new', '--skip-files', '.*generated.*\.go'] + packages.to_a)
      output = result.stdout + result.stderr

      if output.empty?
        return [:pass]
      else
        return [:fail, output]
      end
    end
  end
end
