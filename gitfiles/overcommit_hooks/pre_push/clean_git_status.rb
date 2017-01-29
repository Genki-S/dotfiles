module Overcommit::Hook::PrePush
  class CleanGitStatus < Base
    def run
      status = execute(['git', 'status', '--porcelain']).stdout.split("\n")
      untracked = status.select do |l|
        l =~ /^??/
      end
      modified = status.select do |l|
        l =~ /^ M/
      end
      staged = status.select do |l|
        l =~ /^M/
      end

      all = untracked + modified + staged

      return :pass if all.empty?

      [:fail, "git status not clean"]
    end
  end
end
