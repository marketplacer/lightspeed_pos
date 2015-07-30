require 'lightspeed/category'
require 'lightspeed/account_resources'

module Lightspeed
  class Categories < Lightspeed::AccountResources
    def self.resource_name
      "Category"
    end
  end
end
