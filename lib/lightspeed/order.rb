# frozen_string_literal: true

require_relative 'resource'

module Lightspeed
  class Order < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      orderID: :id,
      orderedDate: :timestamp,
      receivedDate: :timestamp,
      arrivalDate: :timestamp,
      shipInstructions: :integer,
      stockInstructions: :integer,
      shipCost: :decimal,
      otherCost: :decimal,
      complete: :boolean,
      archived: :boolean,
      discount: :boolean,
      totalDiscount: :decimal,
      totalQuantity: :decimal,
      vendorID: :id,
      noteID: :id,
      shopID: :id,
      Vendor: :hash,
      Note: :hash,
      Shop: :hash,
      OrderLines: :hash,
      CustomFieldValues: :hash,
      timeStamp: :timestamp
    )

  end
end

