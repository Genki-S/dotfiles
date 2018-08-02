module Overcommit::Hook::PrePush
  class GoTest < Base
    def run
      execute(['go'], args: ['install', './...'])

      result = execute(['go'], args: ['list', './...'])
      return [:fail, result.stdout + result.stderr] unless result.success?
      all_pkgs = result.stdout.split("\n")
      pkgs = all_pkgs - all_pkgs.grep(/vendor/)

      result = execute(command, args: ['test', '-race', '-timeout', '2s'] + pkgs)
      return :pass if result.success?

      output = result.stdout + result.stderr
      if output.include?('no Go files in')
          return [:warn, output]
      end
      [:fail, output]
    end
  end
end
