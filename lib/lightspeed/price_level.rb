require_relative 'resource'

module Lightspeed
  class PriceLevel < Lightspeed::Resource
    fields(
      priceLevelID: :id,
      name: :string,
      archived: :boolean,
      canBeArchived: :boolean,
      type: :string,
      Calculation: :String
    )
  end
end
