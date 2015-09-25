require_relative 'resource'

module Lightspeed
  class ItemAttributeSet < Lightspeed::Resource
    fields(
      itemAttributeSetID: Lightspeed::ID,
      name: String,
      attributeName1: String,
      attributeName2: String,
      attributeName3: String
    )
  end
end
