require 'lightspeed/item'
require 'lightspeed/account_resource'

module Lightspeed
  class Items < Lightspeed::AccountResource

    alias_method :archive, :destroy

    private

    def self.resource_name
      "Item"
    end
  end
end
