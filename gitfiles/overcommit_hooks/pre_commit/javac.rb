require 'tmpdir'

# TODO: catch LoadError
require 'nokogiri'

module Overcommit::Hook::PreCommit
  class Javac < Base
    def run
      tmpdir = Dir.mktmpdir
      args = [
        # '-d', tmpdir,
        '-Xlint:all',
      ]
      args += config['additional_args']

      if config['classpath_eclipse']
        args += ['-classpath', load_classpath_eclipse]
      end

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

    def load_classpath_eclipse
      doc = File.open(".classpath") { |f| Nokogiri::XML(f) }
      paths = doc.xpath('//classpath/classpathentry/@path').map(&:value)
      paths.join(':')
    end
  end
end
