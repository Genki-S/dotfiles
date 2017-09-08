module Overcommit::Hook::PreCommit
  class Gometalinter < Base
    def run
      execute(['go'], args: ['install', './...'])

      result = execute(['go'], args: ['list', './...'])
      return [:fail, result.stdout + result.stderr] unless result.success?
      all_pkgs = result.stdout.split("\n")
      paths = (all_pkgs - all_pkgs.grep(/vendor/)).map do |pkg|
        # convert to full path, since gometalinter doesn't accept package name
        "#{ENV['GOPATH']}/src/#{pkg}"
      end

      result = execute(command, args: ['--enable-all'] + paths)
      output = result.stdout + result.stderr

      # Fail for errors on these linters even if that's not my change, since the
      # errors are too bad
      fatals = output.split("\n").grep(/ineffassign/)
      return [:fail, fatals.join("\n")] unless fatals.empty?

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
