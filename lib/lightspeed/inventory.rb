require_relative 'resource'

require_relative 'item'

module Lightspeed
  class Inventory < Lightspeed::Resource
    relate :Item
  end
end
