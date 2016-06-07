module Overcommit::Hook::PreCommit
  class Pmd < Base
    def run
      rulesets = config['rulesets'].map { |s| s.gsub(/\$[A-Z]+/) { |m| ENV[m[1..-1]] } }
      result = execute(command, args: ['-d', applicable_files.join(','), '-f', config['format'], '-R', rulesets.join(',')])
      return :pass if result.success?

      output = result.stdout + result.stderr
      [:fail, output]
    end
  end
end
