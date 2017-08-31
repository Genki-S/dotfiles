module Overcommit::Hook::PreCommit
  class GoVet < Base
    def run
      execute(['go'], args: ['install', './...'])

      result = execute(['go'], args: ['list', './...'])
      return [:fail, result.stdout + result.stderr] unless result.success?
      all_pkgs = result.stdout.split("\n")
      pkgs = all_pkgs - all_pkgs.grep(/vendor/)

      result = execute(['go'], args: ['vet'] + pkgs)
      return :pass if result.success?

      output = result.stdout + result.stderr
      [:fail, output]
    end
  end
end
