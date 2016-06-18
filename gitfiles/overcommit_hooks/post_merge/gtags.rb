require_relative '../shared/gtags'

module Overcommit::Hook::PostMerge
  class Gtags < Base
    include Overcommit::Hook::Shared::Gtags
  end
end
