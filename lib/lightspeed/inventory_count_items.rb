require_relative 'collection'

require_relative 'inventory_count_item'

module Lightspeed
  class InventoryCountItems < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end
