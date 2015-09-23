require_relative 'resource'

require_relative 'item_matrix'
require_relative 'category'
require_relative 'images'

module Lightspeed
  class Item < Lightspeed::Resource
    attr_accessor :systemSku, :defaultCost, :avgCost, :discountable, :tax,
      :archived, :itemType, :description, :modelYear, :upc, :ean, :customSku,
      :manufacturerSku, :createTime, :timeStamp,

      # Association keys
      :taxClassID, :departmentID, :manufacturerID, :seasonID,
      :defaultVendorID, :itemECommerceID,

      # Embedded
      :ItemAttributes, :ItemShops, :Prices, :Note, :TaxClass,
      :Manufacturer, :ItemVendorNums, :CustomFieldValues, :Tags

    has_one :ItemMatrix, :Category
    has_many :Images

  end
end
