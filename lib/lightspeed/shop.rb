require_relative 'resource'

module Lightspeed
  class Shop < Lightspeed::Resource
    fields(
      shopID: Lightspeed::ID,
      name: String,
      serviceRate:
      timeZone: String,
      taxLabor: TrueClass,
      labelTitle: String,
      labelMsrp: TrueClass,
      archived: TrueClass,
      contactID: Lightspeed::ID,
      taxCategoryID: Lightspeed::ID,
      receiptSetupID: Lightspeed::ID,
      ccGatewayID: Lightspeed::ID,
      priceLevelID: Lightspeed::ID,
      Contact: Hash,
      TaxCategory: Hash, #requestable object.
      ReceiptSetup: Hash,
      CCGateway: Hash, #requestable object
      PriceLevel: Hash, #requestable object.
      ShelfLocations: Hash,
      Registers: Hash
    )

    relationships :Items
  end
end
