require_relative '../shared/gtags'

module Overcommit::Hook::PostCommit
  class Gtags < Base
    include Overcommit::Hook::Shared::Gtags
  end
end
