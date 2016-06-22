require 'tmpdir'

module Overcommit::Hook::PreCommit
  class Javac < Base
    def run
      tmpdir = Dir.mktmpdir
      classpath_arg = config['classpaths'].map { |path| Dir.glob(path) }.join(':')
      args = [
        '-d', tmpdir,
        '-classpath', classpath_arg,
        '-Xlint:all',
      ]
      args += config['additional_args']
      args += applicable_files

      result = execute(command, args: args)
      FileUtils.remove_entry(tmpdir)

      output = result.stdout + result.stderr

      if result.success?
        output.empty? ? :pass : [:warn, output]
      else
        [:fail, output]
      end
    end
  end
end
