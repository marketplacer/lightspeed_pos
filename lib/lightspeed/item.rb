require 'bigdecimal'

require_relative 'resource'

require_relative 'item_matrix'
require_relative 'category'
require_relative 'images'

module Lightspeed
  class Item < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      itemID: Lightspeed::ID,
      systemSku: String,
      defaultCost: BigDecimal,
      avgCost: BigDecimal,
      discountable: TrueClass,
      tax: TrueClass,
      archived: TrueClass,
      itemType: String,
      description: String,
      modelYear: Integer,
      upc: String,
      ean: String,
      customSku: String,
      manufacturerSku: String,
      createTime: DateTime,
      timeStamp: DateTime,
      categoryID: Lightspeed::ID,
      taxClassID: Lightspeed::ID,
      departmentID: Lightspeed::ID,
      itemMatrixID: Lightspeed::ID,
      manufacturerID: Lightspeed::ID,
      seasonID: Lightspeed::ID,
      defaultVendorID: Lightspeed::ID,
      itemECommerceID: Lightspeed::ID
    )

    relationships :ItemMatrix, :Category, :Images
  end
end
