module Overcommit::Hook::PreCommit
  class NoDebugPrint < Base
    DEBUG_CODES = [
      /System\.out\.println/,
      /fmt.Print/
    ]

    def run
      violations = []

      applicable_files.each do |file|
        File.open(file) do |f|
          f.each_with_index do |line, i|
            DEBUG_CODES.each do |d|
              begin
                if line =~ d
                  violations << { file: file, line: line, line_number: i+1 }
                end
              rescue ArgumentError => e
                # Ignore invalid byte sequence
                raise e unless e.message == "invalid byte sequence in UTF-8"
              end
            end
          end
        end
      end

      output = violations.map do |v|
        "#{v[:file]}:#{v[:line_number]}: [found debug code] #{v[:line]}"
      end.join("\n")
      # Filter error by diff using reviewdog
      filter_res = execute(['reviewdog', '-efm', "%f:%l:%m", '-diff', 'git diff HEAD'], input: output)
      violations = filter_res.stdout + filter_res.stderr

      if violations.empty?
        return [:pass]
      else
        return [:fail, output]
      end
    end
  end
end
