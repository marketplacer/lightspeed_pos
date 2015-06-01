require 'lightspeed/base'

module Lightspeed
  class Item < Lightspeed::Base

    attr_accessor :systemSku, :defaultCost, :avgCost, :discountable, :tax,
      :archived, :itemType, :description, :modelYear, :upc, :ean, :customSku,
      :manufacturerSku, :createTime, :timeStamp,

      # Association keys
      :categoryID, :taxClassID, :departmentID, :itemMatrixID, :manufacturerID, :seasonID,
      :defaultVendorID, :itemECommerceID,

      # Embedded
      :ItemShops, :Prices

    private

    def self.id_field
      "itemID"
    end
  end
end
