module Overcommit::Hook::PreCommit
  class Checkstyle < Base
    def run
      result = execute(command, args: applicable_files)
      output = result.stdout + result.stderr
      return :pass if output.empty?

      output = result.stdout + result.stderr
      [:fail, output]
    end
  end
end
