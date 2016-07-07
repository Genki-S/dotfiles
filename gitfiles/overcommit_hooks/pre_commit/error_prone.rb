module Overcommit::Hook::PreCommit
  class ErrorProne < Base
    def run
      ENV['JAVA_HOME'] = "/usr/java/jdk1.8.0_91"
      ENV['PATH'] = "#{ENV['JAVA_HOME']}/bin:#{ENV['PATH']}"
      result = execute(command, args: ['build', "//:#{config['target']}"])

      if result.success?
        return [:pass]
      else
        output = result.stdout + result.stderr
        return [:fail, output]
      end
    end
  end
end
