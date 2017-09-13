
require_relative 'resource'

module Lightspeed
  class InventoryCountItem < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      inventoryCountItemID: :id,
      qty: :integer,
      timeStamp: :datetime,
      inventoryCountID: :id,
      itemID: :id,
      employeeID: :id
    )
  end
end
