require 'lightspeed/base'
require 'lightspeed/items'

module Lightspeed
  class Account < Lightspeed::Base
    attr_accessor :id, :name, :link

    def items
      item_proxy
    end

    private

    def self.id_field
      "accountID"
    end

    def item_proxy
      @item_proxy ||= Lightspeed::Items.new(id)
    end
  end
end
