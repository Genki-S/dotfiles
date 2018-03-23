module Overcommit::Hook::PreCommit
  class Gometalinter < Base
    def run
      execute(['go'], args: ['install', './...'])

      result = execute(command, args: ['--enable-all'] + applicable_files)

      unless result.stderr.empty?
        return [:fail, 'Missing linter binaries, run `gometailnter --install --update`' + "\n" + result.stderr]
      end

      # Fail for errors on these linters even if that's not my change, since the
      # errors are too bad
      fatals = result.stdout.split("\n").grep(/ineffassign/)
      return [:fail, fatals.join("\n")] unless fatals.empty?

      # Filter error by diff using reviewdog
      filteredResult = execute(['reviewdog', '-efm', "%f:%l:%c:%\\w\\+:%m", '-diff', 'git diff HEAD'], input: result.stdout)
      output = filteredResult.stdout + filteredResult.stderr

      if output.empty?
        return [:pass]
      else
        return [:fail, output]
      end
    end
  end
end
