require_relative 'collection'

require_relative 'shop'

module Lightspeed
  class Shops < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end
