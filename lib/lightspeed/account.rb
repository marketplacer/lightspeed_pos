module Lightspeed
  class Account < Lightspeed::Base
    attr_accessor :id

    def items
      response = get("Item.json")
      items = Lightspeed.instantiate(response["Item"], Lightspeed::Item)
    end

    def find_item(id)
      response = get("Item.json", query: { itemID: id })
      Lightspeed::Item.new(response["Item"])
    end

    private

    def self.id_field
      "accountID"
    end

    def get(path, *args)
      self.class.get("/Account/#{id}/#{path}", *args)
    end
  end
end
