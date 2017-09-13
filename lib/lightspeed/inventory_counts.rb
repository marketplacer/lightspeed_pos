require_relative 'collection'

require_relative 'inventory_count'

module Lightspeed
  class InventoryCounts < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end
