require_relative 'categories'
require_relative 'items'
require_relative 'item_matrices'
require_relative 'item_attribute_sets'
require_relative 'images'
require_relative 'inventories'

module Lightspeed
  class Account < Lightspeed::Resource
    attr_accessor :name, :link

    def account
      self
    end

    relate :Items, :Categories, :ItemMatrices, :ItemAttributeSets, :Images, :Inventories

  end
end
