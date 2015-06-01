require 'lightspeed/item'

module Lightspeed
  class Items

    attr_accessor :account_id
    def initialize(account_id)
      @account_id = account_id
    end

    def all
      response = get
      Lightspeed.instantiate(response["Item"], Lightspeed::Item)
    end

    def find(id)
      response = get(query: { itemID: id })
      Lightspeed::Item.new(response["Item"])
    end

    def create(attributes={})
      response = post(body: attributes.to_json)
      Lightspeed::Item.new(response["Item"])
    end

    private

    def get(*args)
      Lightspeed.request(:get, base_path, *args)
    end

    def post(*args)
      Lightspeed.request(:post, base_path, *args)
    end

    def base_path
      Lightspeed.base_uri + "/Account/#{account_id}/Item.json"
    end
  end
end
