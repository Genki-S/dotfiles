module Overcommit::Hook::PreCommit
  class Checkstyle < Base
    def run
      result = execute(command, args: applicable_files)
      output = result.stdout + result.stderr
      output = output.split("\n").delete_if do |line|
        line =~ /Starting audit.../ ||
        line =~ /Audit done./
      end.join("\n")

      # Filter error by diff using reviewdog
      # TODO: Commonize this process
      result = execute(['reviewdog', '-efm', '[WARN] %f:%l:%c: %m', '-efm', '[WARN] %f:%l: %m', '-efm', '%f:%l: %m', '-diff', 'git diff HEAD'], input: output)
      output = result.stdout + result.stderr

      return :pass if output.empty?
      [:fail, output]
    end
  end
end
