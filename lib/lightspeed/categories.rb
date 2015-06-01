require 'lightspeed/category'
require 'lightspeed/account_resource'

module Lightspeed
  class Categories < Lightspeed::AccountResource

    private

    def self.resource_name
      "Category"
    end
  end
end
