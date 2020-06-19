# frozen_string_literal: true

require_relative 'resource'

module Lightspeed
  class Shop < Lightspeed::Resource
    fields(
      shopID: :id,
      name: :string,
      serviceRate: :decimal,
      timeZone: :string,
      taxLabor: :boolean,
      labelTitle: :string,
      labelMsrp: :boolean,
      archived: :boolean,
      contactID: :id,
      taxCategoryID: :id,
      receiptSetupID: :id,
      ccGatewayID: :id,
      priceLevelID: :id,
      Contact: :hash,
      TaxCategory: :hash, # requestable object.
      ReceiptSetup: :hash,
      CCGateway: :hash, # requestable object
      PriceLevel: :hash, # requestable object.
      ShelfLocations: :hash,
      Registers: :hash
    )

    relationships :Items
  end
end
