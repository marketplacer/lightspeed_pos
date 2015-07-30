module Lightspeed
  class ItemMatrix < Lightspeed::Base
    attr_accessor :description, :tax, :defaultCost, :itemType, :modelYear, :archived,
      :timeStamp

    # Association keys
    attr_accessor :itemAttributeSetID, :manufacturerID, :categoryID, :defaultVendorID,
      :taxClassID, :seasonID, :departmentID, :itemECommerceID

    # Embedded
    attr_accessor :Prices

    def self.id_field
      "itemMatrixID"
    end
  end
end
