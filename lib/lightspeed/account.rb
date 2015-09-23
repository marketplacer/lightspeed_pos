require_relative 'base'
require_relative 'categories'
require_relative 'items'
require_relative 'item_matrices'
require_relative 'item_attribute_sets'
require_relative 'images'
require_relative 'inventories'

module Lightspeed
  class Account < Lightspeed::Resource
    attr_accessor :id, :name, :link

    def client
      owner.client
    end

    def account
      self
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

    def images
      @images ||= Lightspeed::Images.new(self)
    end

    def inventories
      @inventories ||= Lightspeed::Inventories.new(self)
    end

    def instantiate(**args)
      client.instantiate({owner: self}.merge(args))
    end
  end
end
