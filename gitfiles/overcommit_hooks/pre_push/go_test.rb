module Overcommit::Hook::PrePush
  class GoTest < Base
    def run
      result = execute(command, args: ['test', '-race', './...'])
      return :pass if result.success?

      output = result.stdout + result.stderr
      if output.include?('no packages to test')
          return [:warn, output]
      end
      [:fail, output]
    end
  end
end
