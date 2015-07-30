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
      :ItemMatrix, :ItemAttributes, :ItemShops, :Prices, :Note

    def self.id_field
      "itemID"
    end

    # FUNFACT: ItemMatrix data is returned during an `update` request,
    # but not during a `find` request.
    def ItemMatrix
      @ItemMatrix ||= owner.item_matrices.find(itemMatrixID)
    end
  end
end
