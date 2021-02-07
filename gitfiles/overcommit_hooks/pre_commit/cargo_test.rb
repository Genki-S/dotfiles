# overcommit provide CargoTest for only PrePush, but I want it at PreCommit
module Overcommit::Hook::PreCommit
  class CargoTest < Base
    def run
      result = execute(command)
      return :pass if result.success?
      [:fail, result.stdout]
    end
  end
end
