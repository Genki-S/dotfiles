module Overcommit::Hook::PreCommit
  class ErrorProne < Base
    def run
      result = execute(command, args: ['build', "//:#{config['target']}"])

      if result.success?
        return [:pass]
      else
        output = result.stdout + result.stderr
        return [:fail, output]
      end
    end
  end
end
