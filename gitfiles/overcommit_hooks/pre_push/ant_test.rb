module Overcommit::Hook::PrePush
  class AntTest < Base
    def run
      return [:warn, "No build.xml... skipping."] unless File.exist?('build.xml')

      result = execute(command, args: ['test'])
      return :pass if result.success?

      output = result.stdout + result.stderr
      [:fail, output]
    end
  end
end
