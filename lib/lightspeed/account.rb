require 'uri'
require_relative 'categories'
require_relative 'customers'
require_relative 'employees'
require_relative 'items'
require_relative 'item_matrices'
require_relative 'item_attribute_sets'
require_relative 'images'
require_relative 'inventories'
require_relative 'orders'
require_relative 'order_lines'
require_relative 'price_levels'
require_relative 'sales'
require_relative 'shops'
require_relative 'special_orders'
require_relative 'tax_classes'
require_relative 'transfers'
require_relative 'vendors'

module Lightspeed
  class Account < Lightspeed::Resource
    fields(
      accountID: :id,
      name: :string,
      link: :hash
    )
    relationships(
      :Categories,
      :Customers,
      :Employees,
      :Images,
      :Inventories,
      :ItemMatrices,
      :ItemAttributeSets,
      :Items,
      :Orders,
      :OrderLines,
      :PriceLevels,
      :Sales,
      :Shops,
      :SpecialOrders,
      :TaxClasses,
      :Transfers,
      :Vendors
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
