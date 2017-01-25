module Overcommit::Hook::PreCommit
  class NoDebugPrint < Base
    DEBUG_CODES = [
      /System\.out\.println/
    ]

    def run
      violations = []

      applicable_files.each do |file|
        File.open(file) do |f|
          f.each_with_index do |line, i|
            DEBUG_CODES.each do |d|
              if line =~ d
                  violations << { file: file, line: line, line_number: i+1 }
              end
            end
          end
        end
      end

      if violations.empty?
        return [:pass]
      else
        output = violations.map do |v|
          "#{v[:file]}:#{v[:line_number]}: [found debug code] #{v[:line]}"
        end.join("\n")
        return [:fail, output]
      end
    end
  end
end
