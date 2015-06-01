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

    def update(id, attributes={})
      response = put(id, body: attributes.to_json)
      Lightspeed::Item.new(response["Item"])
    end

    def archive(id, attributes={})
      response = delete(id)
      Lightspeed::Item.new(response["Item"])
    end

    private

    def get(*args)
      Lightspeed.request(:get, collection_path, *args)
    end

    def post(*args)
      Lightspeed.request(:post, collection_path, *args)
    end

    def put(id, *args)
      Lightspeed.request(:put, item_path(id), *args)
    end

    def delete(id)
      Lightspeed.request(:delete, item_path(id))
    end

    def base_path
      Lightspeed.base_uri + "/Account/#{account_id}/Item"
    end

    def collection_path
      base_path + ".json"
    end

    def item_path(id)
      base_path + "/#{id}.json"
    end
  end
end
