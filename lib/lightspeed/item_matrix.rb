module Lightspeed
  class ItemMatrix < Lightspeed::Base
    attr_accessor :description, :tax, :defaultCost, :itemType, :modelYear, :archived,
      :timeStamp

    # Association keys
    attr_accessor :itemAttributeSetID, :manufacturerID, :categoryID, :defaultVendorID,
      :taxClassID, :seasonID, :departmentID, :itemECommerceID

    # Embedded
    attr_accessor :Prices, :ItemAttributeSet, :TaxClass, :Items, :Manufacturer

    def self.id_field
      "itemMatrixID"
    end

    def item_attribute_set
      return if itemAttributeSetID.to_i.zero?
      @ItemAttributeSet ||= owner.item_attribute_sets.find(itemAttributeSetID) # rubocop:disable VariableName
    end
  end
end
