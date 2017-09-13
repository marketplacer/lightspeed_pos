require_relative 'collection'

require_relative 'inventory_count_reconcile'

module Lightspeed
  class InventoryCountReconciles < Lightspeed::Collection
    alias_method :archive, :destroy
  end
end
