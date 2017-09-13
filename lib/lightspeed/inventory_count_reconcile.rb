
require_relative 'resource'

module Lightspeed
  class InventoryCountReconcile < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      inventoryCountReconcileID: :id,
      createTime: :datetime,
      costChange: :decimal,
      qohChange: :integer,
      inventoryCountID: :id,
      itemID: :id
    )
  end
end
