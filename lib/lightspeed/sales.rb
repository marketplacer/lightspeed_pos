require_relative 'collection'

require_relative 'sale'

module Lightspeed
  class Sales < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end

