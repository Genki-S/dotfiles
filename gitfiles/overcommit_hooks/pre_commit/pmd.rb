module Overcommit::Hook::PreCommit
  class Pmd < Base
    WARNING_MESSAGE_REGEXPS = [
      /A class which only has private constructors should be final/,
      /Avoid using Literals in Conditional Statements/,
      /Too many static imports may lead to messy code/,
      /This class has too many methods, consider refactoring it/,
      /The String literal [^ ]* appears \d+ times in this file/,
      /A high number of imports can indicate a high degree of coupling within an object/,
      /The (method|class) [^ ]* has a (Modified |Standard |)Cyclomatic Complexity of \d+/,
      /Avoid instantiating new objects inside loops/,
    ]

    def run
      rulesets = config['rulesets'].map { |s| s.gsub(/\$[A-Z]+/) { |m| ENV[m[1..-1]] } }
      result = execute(command, args: ['-d', applicable_files.join(','), '-f', config['format'], '-R', rulesets.join(',')])
      output = result.stdout + result.stderr

      error_messages = output.split("\n").delete_if do |line|
        WARNING_MESSAGE_REGEXPS.any? { |pat| pat.match(line) }
      end

      unless error_messages.empty?
        return [:fail, error_messages.join("\n")]
      end

      if output.empty?
        return [:pass]
      else
        return [:warn, output]
      end
    end
  end
end
