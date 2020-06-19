# frozen_string_literal: true

require_relative 'resource'

require_relative 'item_matrix'
require_relative 'category'
require_relative 'images'
require_relative 'prices'

module Lightspeed
  class Item < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      itemID: :id,
      systemSku: :string,
      defaultCost: :decimal,
      avgCost: :decimal,
      discountable: :boolean,
      tax: :boolean,
      archived: :boolean,
      itemType: :string,
      description: :string,
      modelYear: :integer,
      upc: :string,
      ean: :string,
      customSku: :string,
      manufacturerSku: :string,
      createTime: :datetime,
      timeStamp: :datetime,
      categoryID: :id,
      taxClassID: :id,
      departmentID: :id,
      itemMatrixID: :id,
      manufacturerID: :id,
      seasonID: :id,
      defaultVendorID: :id,
      itemECommerceID: :id,
      # Category: :hash,
      TaxClass: :hash,
      Department: :hash,
      ItemAttributes: :hash,
      # ItemMatrix: :hash,
      # Images: :hash,
      Manufacturer: :hash,
      Note: :hash,
      ItemECommerce: :hash,
      ItemShops: :hash,
      ItemComponents: :hash,
      ItemShelfLocations: :hash,
      ItemVendorNums: :hash,
      CustomFieldValues: :hash,
      Prices: :hash,
      Tags: :hash
    )

    relationships :ItemMatrix, :Category, :Images, DefaultVendor: :Vendor

    def prices
      @prices ||= Lightspeed::Prices.new(self.Prices)
    end
  end
end
