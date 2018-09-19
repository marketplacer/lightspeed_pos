require_relative 'resource'

module Lightspeed
  class OrderLine < Lightspeed::Resource
    fields(
      orderLineID: :integer,
      quantity: :integer,
      price: :decimal,
      originalPrice: :decimal,
      checkedIn: :integer,
      numReceived: :integer,
      orderID: :integer,
      itemID: :integer,
      timeStamp: :datetime,
      total: :decimal
    )
  end
end
