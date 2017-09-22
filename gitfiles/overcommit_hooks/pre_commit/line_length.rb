module Overcommit::Hook::PreCommit
  class LineLength < Base
    def run
      warns = []
      errors = []
      warn_length = config['warn_length']
      error_length = config['error_length']
      applicable_files.each do |f|
        File.readlines(f).each_with_index do |l, i|
          if l.length > error_length
            errors << "#{f}:#{i+1}: (error) line too long (#{l.length} > #{error_length})"
          elsif l.length > warn_length
            warns << "#{f}:#{i+1}: (warn) line too long (#{l.length} > #{warn_length})"
          end
        end
      end

      # Filter error by diff using reviewdog
      filter_res = execute(['reviewdog', '-efm', "%f:%l:%m", '-diff', 'git diff HEAD'], input: errors.join("\n"))
      errors = filter_res.stdout + filter_res.stderr
      filter_res = execute(['reviewdog', '-efm', "%f:%l:%m", '-diff', 'git diff HEAD'], input: warns.join("\n"))
      warns = filter_res.stdout + filter_res.stderr

      if !errors.empty?
        return [:fail, errors + warns]
      elsif !warns.empty?
        return [:warn, warns]
      else
        return :pass
      end
    end
  end
end
