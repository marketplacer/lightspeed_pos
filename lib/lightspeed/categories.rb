require 'lightspeed/category'

module Lightspeed
  class Categories
    attr_accessor :account_id

    def initialize(account_id)
      @account_id = account_id
    end

    def all
      response = get
      Lightspeed.instantiate(response["Category"], Lightspeed::Category)
    end

    def create(attributes={})
      response = post(body: attributes.to_json)
      Lightspeed::Category.new(response["Category"])
    end

    private

    def get(*args)
      Lightspeed.request(:get, collection_path, *args)
    end

    def post(*args)
      Lightspeed.request(:post, collection_path, *args)
    end

    def base_path
      Lightspeed.base_uri + "/Account/#{account_id}/Category"
    end

    def collection_path
      base_path + ".json"
    end
  end
end
