require 'lightspeed/item_matrix'
require 'lightspeed/account_resources'

module Lightspeed
  class ItemMatrices < AccountResources
    private

    def self.resource_name
      "ItemMatrix"
    end
  end
end
