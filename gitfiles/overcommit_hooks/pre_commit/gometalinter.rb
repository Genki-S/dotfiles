module Overcommit::Hook::PreCommit
  class Gometalinter < Base
    def run
      result = execute(command, args: ['./...'])
      output = result.stdout + result.stderr

      # Filter error by diff using reviewdog
      result = execute(['reviewdog', '-efm', "%f:%l:%c:%\\w\\+:%m", '-diff', 'git diff HEAD'], input: output)
      output = result.stdout + result.stderr

      if output.empty?
        return [:pass]
      else
        return [:fail, output]
      end
    end
  end
end
