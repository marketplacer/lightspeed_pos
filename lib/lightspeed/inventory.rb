module Lightspeed
  class Inventory < Lightspeed::Base
    attr_accessor :itemID

    def self.id_field
      "inventoryID"
    end
  end
end
