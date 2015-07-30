require 'lightspeed/item'
require 'lightspeed/account_resources'

module Lightspeed
  class Items < Lightspeed::AccountResources
    alias_method :archive, :destroy

    def self.resource_name
      "Item"
    end
  end
end
