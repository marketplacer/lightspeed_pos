
require_relative 'resource'

module Lightspeed
  class InventoryCount < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      inventoryCountID: :id,
      name: :string,
      timeStamp: :datetime,
      archived: :boolean,
      shopID: :id
    )
  end
end
