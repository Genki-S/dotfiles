require_relative '../shared/gtags'

module Overcommit::Hook::PostCheckout
  class Gtags < Base
    include Overcommit::Hook::Shared::Gtags
  end
end
