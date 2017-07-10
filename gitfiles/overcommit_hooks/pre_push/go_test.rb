module Overcommit::Hook::PrePush
  class GoTest < Base
    def run
      execute(['go'], args: ['install', './...'])

      result = execute(command, args: ['test', '-race', './...', '-timeout', '2s'])
      return :pass if result.success?

      output = result.stdout + result.stderr
      if output.include?('no packages to test')
          return [:warn, output]
      end
      [:fail, output]
    end
  end
end
