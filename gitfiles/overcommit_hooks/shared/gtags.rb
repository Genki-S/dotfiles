module Overcommit::Hook::Shared
  module Gtags
    def run
      Dir.chdir(config['root_dir'] || Dir.pwd) do
        execute_in_background(['gtags', '-v'])
      end
      :pass
    end
  end
end
