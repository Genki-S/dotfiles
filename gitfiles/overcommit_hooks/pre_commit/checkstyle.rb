module Overcommit::Hook::PreCommit
  class Checkstyle < Base
    def run
      result = execute(command, args: applicable_files)
      output = result.stdout + result.stderr
      output = output.split("\n").delete_if do |line|
        line =~ /Starting audit.../ ||
        line =~ /Audit done./
      end.join("\n")

      return :pass if output.empty?
      [:fail, output]
    end
  end
end
