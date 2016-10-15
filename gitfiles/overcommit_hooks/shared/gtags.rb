module Overcommit::Hook::Shared
  module Gtags
    def run
      Dir.chdir(config['root_dir'] || Dir.pwd) do
        # TODO: replace G{TAGS,RTAGS,PATH} like effortless-ctags
        execute_in_background(['gtags', '--gtagslabel=pygments'])
      end
      :pass
    end
  end
end
