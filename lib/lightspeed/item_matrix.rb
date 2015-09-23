require_relative 'resource'

require_relative 'item_attribute_set'
require_relative 'category'
require_relative 'items'

module Lightspeed
  class ItemMatrix < Lightspeed::Resource
    attr_accessor :description, :tax, :defaultCost, :itemType, :modelYear, :archived,
      :timeStamp

    # Association keys
    attr_accessor :manufacturerID, :defaultVendorID,
      :taxClassID, :seasonID, :departmentID, :itemECommerceID

    # Embedded
    attr_accessor :Prices, :TaxClass, :Manufacturer

    has_one :ItemAttributeSet, :Category
    has_many :Items

    def self.collection_name
      'ItemMatrices'
    end

  end
end
