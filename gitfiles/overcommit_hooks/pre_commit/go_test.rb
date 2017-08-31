module Overcommit::Hook::PreCommit
  class GoTest < Base
    def run
      execute(['go'], args: ['install', './...'])

      result = execute(['go'], args: ['list', './...'])
      return [:fail, result.stdout + result.stderr] unless result.success?
      all_pkgs = result.stdout.split("\n")
      pkgs = all_pkgs - all_pkgs.grep(/vendor/)

      # No `-race` option for pre-commit (`-race` test is done on pre-push)
      result = execute(command, args: ['test', '-timeout', '1s'] + pkgs)
      return :pass if result.success?

      output = result.stdout + result.stderr
      if output.include?('no packages to test')
          return [:warn, output]
      end
      [:fail, output]
    end
  end
end
