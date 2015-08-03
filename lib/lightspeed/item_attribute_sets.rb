require 'lightspeed/item_attribute_set'
require 'lightspeed/account_resources'

module Lightspeed
  class ItemAttributeSets < AccountResources
    def self.resource_name
      "ItemAttributeSet"
    end
  end
end
