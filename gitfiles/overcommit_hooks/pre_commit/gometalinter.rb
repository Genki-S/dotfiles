module Overcommit::Hook::PreCommit
  class Gometalinter < Base
    def run
      result = execute(command, args: ['./...'])
      output = result.stdout + result.stderr

      if result.success?
        return [:pass]
      else
        return [:fail, output]
      end
    end
  end
end
