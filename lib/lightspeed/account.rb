require 'lightspeed/base'
require 'lightspeed/item_proxy'

module Lightspeed
  class Account < Lightspeed::Base
    attr_accessor :id

    def items
      item_proxy.all
    end

    def find_item(item_id)
      item_proxy.find(item_id)
    end

    private

    def self.id_field
      "accountID"
    end

    def item_proxy
      @item_proxy ||= Lightspeed::ItemProxy.new(id)
    end
  end
end
