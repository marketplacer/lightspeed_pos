require 'lightspeed/base'

module Lightspeed
  class Item < Lightspeed::Base

    private

    def self.id_field
      "itemID"
    end
  end
end
