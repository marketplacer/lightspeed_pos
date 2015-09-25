require_relative 'resource'

module Lightspeed
  class Shop < Lightspeed::Resource
    fields(
      shopID: Lightspeed::ID,
      name: String
    )

    relationships :Items
  end
end
