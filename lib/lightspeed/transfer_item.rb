require_relative 'resource'

module Lightspeed
  class TransferItem < Lightspeed::Resource
    fields(
      transferItemID: :integer,
      toSend: :integer,
      toReceive: :integer,
      sent: :integer,
      received: :integer,
      sentValue: :integer,
      receivedValue: :integer,
      comment: :string,
      timeStamp: :datetime,
      transferID: :integer,
      itemID: :integer
    )
  end
end
