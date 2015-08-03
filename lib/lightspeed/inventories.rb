require 'lightspeed/account_resources'
require 'lightspeed/inventory'

module Lightspeed
  class Inventories < AccountResources
    def self.resource_name
      "Inventory"
    end
  end
end
