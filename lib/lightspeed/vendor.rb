# frozen_string_literal: true

require_relative 'resource'

module Lightspeed
  class Vendor < Lightspeed::Resource
    alias_method :archive, :destroy

    fields(
      vendorID: :id,
      name: :string,
      archived: :boolean,
      accountNumber: :string,
      priceLevel: :string,
      updatePrice: :boolean,
      updateCost: :boolean,
      updateDescription: :boolean,
      shareSellThrough: :boolean,
      timeStamp: :datetime,
      Contact: :hash,
      Reps: :hash
    )

  end
end
