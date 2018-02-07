require 'uri'
require_relative 'categories'
require_relative 'employees'
require_relative 'items'
require_relative 'item_matrices'
require_relative 'item_attribute_sets'
require_relative 'images'
require_relative 'inventories'
require_relative 'orders'
require_relative 'price_levels'
require_relative 'sales'
require_relative 'shops'
require_relative 'special_orders'
require_relative 'vendors'
require_relative 'customers'

module Lightspeed
  class Account < Lightspeed::Resource
    fields(
      accountID: :id,
      name: :string,
      link: :hash
    )
    relationships(
      :Categories,
      :Employees,
      :Images,
      :Inventories,
      :ItemMatrices,
      :ItemAttributeSets,
      :Items,
      :Orders,
      :PriceLevels,
      :Sales,
      :Shops,
      :SpecialOrders,
      :Vendors,
      :Customers
    )

    def account
      self
    end

    def link
      if @link.is_a?(Hash)
        @link['@attributes']['href']
      else
        @link
      end
    end
  end
end
