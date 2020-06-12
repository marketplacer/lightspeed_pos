# frozen_string_literal: true

require_relative 'resource'

require_relative 'item_attribute_set'
require_relative 'category'
require_relative 'items'

module Lightspeed
  class ItemMatrix < Lightspeed::Resource
    fields(
      itemMatrixID: :id,
      description: :string,
      tax: :boolean,
      defaultCost: :decimal,
      itemType: :string,
      modelYear: :integer,
      archived: :boolean,
      timeStamp: :datetime,
      itemAttributeSetID: :id,
      manufacturerID: :id,
      categoryID: :id,
      defaultVendorID: :id,
      taxClassID: :id,
      seasonID: :id,
      departmentID: :id,
      itemECommerceID: :id,
      itemAttributeSet: :hash,
      Manufacturer: :hash,
      Category: :hash,
      TaxClass: :hash,
      Season: :hash,
      Department: :hash,
      ItemECommerce: :hash,
      Images: :hash,
      Items: :hash,
      CustomFieldValues: :hash,
      Prices: :hash
    )

    relationships :ItemAttributeSet, :Category, :Items

    # overrides

    def self.collection_name
      'ItemMatrices'
    end

    def singular_path_parent
      account
    end

    def prices
      @prices ||= Lightspeed::Prices.new(self.Prices)
    end
  end
end
