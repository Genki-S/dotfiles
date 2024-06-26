module Overcommit::Hook::PreCommit
  class GoTest < Base
    def run
      # No `-race` option for pre-commit (`-race` test is done on pre-push)
      result = execute(command, args: ['-timeout', '1s', './...'])
      return :pass if result.success?

      output = result.stdout + result.stderr
      if output.include?('no Go files in')
          return [:warn, output]
      end
      [:fail, output]
    end
  end
end
