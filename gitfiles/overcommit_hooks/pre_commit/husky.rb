module Overcommit::Hook::PreCommit
  class Husky < Base
    def run
      return [:pass] unless File.exist?('package.json')

      require 'json'
      package = JSON.parse(File.read('package.json'))
      hook = package['scripts']['precommit']
      return [:pass] unless hook

      result = execute(hook.split)
      output = result.stdout + result.stderr

      if result.success?
        return [:pass]
      else
        return [:fail, output]
      end
    end
  end
end
