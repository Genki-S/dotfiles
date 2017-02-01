module Overcommit::Hook::PreCommit
  class JavaImportOrder < Base
    def run
      violations = []
      applicable_files.each do |f|
        import_lines = []
        java_imports = []
        javax_imports = []
        static_imports = []
        other_imports = []
        File.readlines(f).each_with_index do |l, i|
          if l =~ /^package/
            next
          end

          if (not l.chomp.empty?) && (not l =~ /^import/)
            break
          end

          l = l.sub(/;$/, '') # for sorting purpose ("." is smaller than ";")
          import_lines << l
          if l =~ /^import javax/
            javax_imports << l
          elsif l =~ /^import java/
            java_imports << l
          elsif l =~ /^import static/
            static_imports << l
          elsif l =~ /^import/
            other_imports << l
          end
        end

        expected = (other_imports.sort + ["\n"] + javax_imports.sort + java_imports.sort + ["\n"] + static_imports.sort).join('').strip
        actual = import_lines.join('').strip

        if expected != actual
          violations << "#{f}:1: import order is not following convention"
        end
      end

      return :pass if violations.empty?
      [:fail, violations.join("\n")]
    end
  end
end
