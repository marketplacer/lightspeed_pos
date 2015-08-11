require 'lightspeed/base'
require 'lightspeed/categories'
require 'lightspeed/items'
require 'lightspeed/item_matrices'
require 'lightspeed/item_attribute_sets'
require 'lightspeed/inventories'

module Lightspeed
  class Account < Lightspeed::Base
    attr_accessor :id, :name, :link

    def self.id_field
      "accountID"
    end

    def client
      owner
    end

    def items
      @items ||= Lightspeed::Items.new(self)
    end

    def categories
      @categories ||= Lightspeed::Categories.new(self)
    end

    def item_matrices
      @item_matrices ||= Lightspeed::ItemMatrices.new(self)
    end

    def item_attribute_sets
      @item_attribute_sets ||= Lightspeed::ItemAttributeSets.new(self)
    end

    def inventories
      @inventories ||= Lightspeed::Inventories.new(self)
    end

    def instantiate(*args)
      args << self
      client.instantiate(*args)
    end
  end
end
