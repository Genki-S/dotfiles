module Overcommit::Hook::PreCommit
  class PlaySound < Base
    def run
      sound = ENV['PRECOMMIT_SOUND']
      return :pass if sound.nil?

      pid = spawn('ffplay', '-nodisp', '-autoexit', '-volume', '100', sound, { out: '/dev/null', err: '/dev/null' })
      Process.detach(pid)
      return :pass
    end
  end
end
