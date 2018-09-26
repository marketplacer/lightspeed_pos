require_relative 'resource'

module Lightspeed
  class TransferItem < Lightspeed::Resource
    fields(
      transferItemID: :integer,
      toSend: :integer,
      toReceive: :integer,
      sent: :integer,
      received: :integer,
      sentValue: :float,
      receivedValue: :float,
      comment: :string,
      timeStamp: :datetime,
      transferID: :integer,
      itemID: :integer
    )
  end
end
