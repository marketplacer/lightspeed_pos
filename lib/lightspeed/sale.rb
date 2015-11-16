require_relative 'resource'

require_relative 'sale_lines'
# require_relative 'category'
# require_relative 'images'
# require_relative 'prices'

module Lightspeed
  class Sale < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      # itemID: :id,
      # systemSku: :string,
      # defaultCost: :decimal,
      # avgCost: :decimal,
      # discountable: :boolean,
      # tax: :boolean,
      # archived: :boolean,
      # itemType: :string,
      # description: :string,
      # modelYear: :integer,
      # upc: :string,
      # ean: :string,
      # customSku: :string,
      # manufacturerSku: :string,
      # createTime: :datetime,
      # timeStamp: :datetime,
      # categoryID: :id,
      # taxClassID: :id,
      # departmentID: :id,
      # itemMatrixID: :id,
      # manufacturerID: :id,
      # seasonID: :id,
      # defaultVendorID: :id,
      # itemECommerceID: :id,
      # # Category: :hash,
      # TaxClass: :hash,
      # Department: :hash,
      # ItemAttributes: :hash,
      # # ItemMatrix: :hash,
      # # Images: :hash,
      # Manufacturer: :hash,
      # Note: :hash,
      # ItemECommerce: :hash,
      # ItemShops: :hash,
      # ItemComponents: :hash,
      # ItemShelfLocations: :hash,
      # ItemVendorNums: :hash,
      # CustomFieldValues: :hash,
      # Prices: :hash,
      # Tags: :hash
    )

    relationships :SaleLines

  end
end

