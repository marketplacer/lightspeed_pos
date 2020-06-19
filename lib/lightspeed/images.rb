# frozen_string_literal: true

require_relative 'collection'

require_relative 'image'

module Lightspeed
  class Images < Lightspeed::Collection
    def base_path
      if context.is_a?(Lightspeed::Item) ||
         context.is_a?(Lightspeed::ItemMatrix)
        "#{context.base_path}/#{resource_name}"
      else
        super
      end
    end
  end
end
