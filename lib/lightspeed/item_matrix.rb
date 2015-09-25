require_relative 'resource'

require_relative 'item_attribute_set'
require_relative 'category'
require_relative 'items'

module Lightspeed
  class ItemMatrix < Lightspeed::Resource
    fields(
      itemMatrixID: Lightspeed::ID,
      description: String,
      tax: TrueClass,
      defaultCost: BigDecimal,
      itemType: String,
      modelYear: Integer,
      archived: TrueClass,
      timeStamp: DateTime,
      itemAttributeSetID: Lightspeed::ID,
      manufacturerID: Lightspeed::ID,
      categoryID: Lightspeed::ID,
      defaultVendorID: Lightspeed::ID,
      taxClassID: Lightspeed::ID,
      seasonID: Lightspeed::ID,
      departmentID: Lightspeed::ID,
      itemECommerceID: Lightspeed::ID,
    )

    relationships :ItemAttributeSet, :Category, :Items

    # overrides

    def self.collection_name
      'ItemMatrices'
    end

    def singular_path_parent
      account
    end
  end
end
