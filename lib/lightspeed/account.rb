module Lightspeed
  class Account < Lightspeed::Base
    attr_accessor :id

    def items
      response = get("Item.json")
      items = Lightspeed.instantiate(response["Item"], Lightspeed::Item)
    end

    private

    def self.id_field
      "accountID"
    end

    def get(path)
      self.class.get("/Account/#{id}/#{path}")
    end
  end
end
