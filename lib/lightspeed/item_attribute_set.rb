# frozen_string_literal: true

require_relative 'resource'

module Lightspeed
  class ItemAttributeSet < Lightspeed::Resource
    fields(
      itemAttributeSetID: :id,
      name: :string,
      attributeName1: :string,
      attributeName2: :string,
      attributeName3: :string
    )
  end
end
