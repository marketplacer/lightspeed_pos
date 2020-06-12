# frozen_string_literal: true

require_relative 'collection'

require_relative 'item_matrix'

module Lightspeed
  class ItemMatrices < Lightspeed::Collection
    def self.resource_name
      "ItemMatrix"
    end
  end
end
