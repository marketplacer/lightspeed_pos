require 'lightspeed/base'
require 'lightspeed/categories'
require 'lightspeed/items'
require 'lightspeed/item_matrices'

module Lightspeed
  class Account < Lightspeed::Base
    attr_accessor :id, :name, :link

    def client
      owner
    end

    def items
      item_proxy
    end

    def categories
      category_proxy
    end

    def item_matrices
      item_matrices_proxy
    end

    def instantiate(*args)
      client.instantiate(self, *args)
    end

    private

    def self.id_field
      "accountID"
    end

    def item_proxy
      @item_proxy ||= Lightspeed::Items.new(self)
    end

    def category_proxy
      @category_proxy ||= Lightspeed::Categories.new(self)
    end

    def item_matrices_proxy
      @item_matrices_proxy ||= Lightspeed::ItemMatrices.new(self)
    end
  end
end
