require_relative 'resource'

require_relative 'item'

module Lightspeed
  class Inventory < Lightspeed::Resource
    has_one :Item
  end
end
