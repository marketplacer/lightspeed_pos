require_relative 'resource'

module Lightspeed
  class Shop < Lightspeed::Resource
    alias_method :archive, :destroy

    # attr_accessor :systemSku, :defaultCost, :avgCost, :discountable, :tax,
    #               :archived, :itemType, :description, :modelYear, :upc, :ean, :customSku,
    #               :manufacturerSku, :createTime, :timeStamp,
    # 
    #               # Association keys
    #               :taxClassID, :departmentID, :manufacturerID, :seasonID,
    #               :defaultVendorID, :itemECommerceID,
    # 
    #               # Embedded
    #               :ItemAttributes, :ItemShops, :Prices, :Note, :TaxClass,
    #               :Manufacturer, :ItemVendorNums, :CustomFieldValues, :Tags

    relate :Items
  end
end




