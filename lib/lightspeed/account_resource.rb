module Lightspeed
  class AccountResource
    attr_accessor :account_id

    def initialize(account_id)
      @account_id = account_id
    end

    def all
      response = get
      Lightspeed.instantiate(response[resource_name], Lightspeed.const_get(resource_name))
    end

    def find(id)
      response = get(query: { "#{resource_name.downcase}ID" => id })
      resource_class.new(response[resource_name])
    end

    def create(attributes={})
      response = post(body: attributes.to_json)
      resource_class.new(response[resource_name])
    end

    def update(id, attributes={})
      response = put(id, body: attributes.to_json)
      resource_class.new(response[resource_name])
    end

    def destroy(id, attributes={})
      response = delete(id)
      resource_class.new(response[resource_name])
    end

    private

    def resource_class
      Lightspeed.const_get(resource_name)
    end

    def resource_name
      self.class.resource_name
    end

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
      Lightspeed.base_uri + "/Account/#{account_id}/#{self.class.resource_name}"
    end

    def collection_path
      base_path + ".json"
    end

    def item_path(id)
      base_path + "/#{id}.json"
    end
  end
end
