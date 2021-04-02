module Overcommit::Hook::PrePush
  class GoTest < Base
    def run
      result = execute(command, args: ['-race', '-timeout', '2s', './...'])
      return :pass if result.success?

      output = result.stdout + result.stderr
      if output.include?('cannot find main module')
          return [:warn, output]
      end
      [:fail, output]
    end
  end
end
