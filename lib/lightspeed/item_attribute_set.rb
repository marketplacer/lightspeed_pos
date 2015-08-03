require 'lightspeed/base'

module Lightspeed
  class ItemAttributeSet < Lightspeed::Base
    attr_accessor :name, :attributeName1, :attributeName2, :attributeName3

    def self.id_field
      "itemAttributeSetID"
    end
  end
end
