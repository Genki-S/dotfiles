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

      if !errors.empty?
        return [:fail, (errors + warns).sort.join("\n")]
      elsif !warns.empty?
        return [:warn, warns.join("\n")]
      else
        return :pass
      end
    end
  end
end
