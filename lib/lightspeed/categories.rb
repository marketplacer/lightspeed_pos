# frozen_string_literal: true

require_relative 'category'
require_relative 'collection'

module Lightspeed
  class Categories < Lightspeed::Collection
    def load_relations_default
      nil
    end
  end
end
