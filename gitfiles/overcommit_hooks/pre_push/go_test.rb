module Overcommit::Hook::PrePush
  class GoTest < Base
    def run
      result = execute(command, args: ['test', './...'])
      return :pass if result.success?

      output = result.stdout + result.stderr
      [:fail, output]
    end
  end
end
