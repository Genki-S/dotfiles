require 'tmpdir'

module Overcommit::Hook::PreCommit
  class Javac < Base
    def run
      tmpdir = Dir.mktmpdir
      classpath_arg = config['classpaths'].map { |path| Dir.glob(path) }.join(':')
      args = [
        '-d', tmpdir,
        '-classpath', classpath_arg,
      ]
      args += config['additional_args']

      result = execute_with_rules(config['must_rules'], args)
      output = result.stdout + result.stderr
      output = output.split("\n").delete_if do |line|
        line =~ /Note: Some input files use or override a deprecated API./ ||
        line =~ /Note: Recompile with -Xlint:deprecation for details./ ||
        line =~ /Note: Some input files use unchecked or unsafe operations./ ||
        line =~ /Note: Recompile with -Xlint:unchecked for details./
      end.join("\n")

      if !result.success? || !output.empty?
        FileUtils.remove_entry(tmpdir)
        return [:fail, output]
      end

      result = execute_with_rules(config['warn_rules'], args)
      output = result.stdout + result.stderr

      FileUtils.remove_entry(tmpdir)
      if output.empty?
        :pass
      else
        [:warn, output]
      end
    end

    def execute_with_rules(rules, args)
      lint_args = rules.map { |rule| "-Xlint:#{rule}" }
      execute(command, args: args + lint_args + applicable_files)
    end
  end
end
