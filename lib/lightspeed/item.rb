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
      :ItemMatrix, :ItemAttributes, :ItemShops, :Prices, :Note, :TaxClass, :Category,
      :Manufacturer, :Images, :ItemVendorNums, :CustomFieldValues, :Tags

    def self.id_field
      "itemID"
    end

    # FUNFACT: ItemMatrix data is returned during an `update` request,
    # but not during a `find` request.
    def item_matrix
      return if itemMatrixID.to_i.zero?
      @ItemMatrix ||= owner.item_matrices.find(itemMatrixID) # rubocop:disable VariableName
    end
  end
end
