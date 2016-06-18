require_relative '../shared/gtags'

module Overcommit::Hook::PostRewrite
  class Gtags < Base
    include Overcommit::Hook::Shared::Gtags
  end
end
