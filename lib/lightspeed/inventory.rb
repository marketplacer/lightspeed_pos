require_relative 'resource'

require_relative 'item'

module Lightspeed
  class Inventory < Lightspeed::Resource
    fields(
      inventoryID: Integer
    )
    relationships :Item
  end
end
