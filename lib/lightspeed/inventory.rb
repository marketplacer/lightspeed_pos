# frozen_string_literal: true

require_relative 'resource'

require_relative 'item'

module Lightspeed
  class Inventory < Lightspeed::Resource
    fields(
      inventoryID: :integer
    )
    relationships :Item
  end
end
