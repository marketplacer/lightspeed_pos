require 'active_support/core_ext/string'
require 'active_support/core_ext/array/wrap'

module Lightspeed
  class Collection

    PER_PAGE = 100 # the max page of records returned in a request

    attr_accessor :context, :resources

    def initialize(context: , attributes: nil)
      self.context = context
      instantiate(attributes)
    end

    def account
      context.account
    end

    def resources
      @resources ||= {}
    end

    def unload
      self.resources = {}
    end

    def client
      return context if context.is_a?(Lightspeed::Client)
      account.client
    end

    def first(params: {}, request: true)
      loaded = resources.each_value.first
      return loaded if loaded || !request
      first!(params: params)
    end

    def first!(params: {})
      params.merge(limit: 1)
      instantiate(get(params: params)).first
    end

    def all(params: {}, request: true)
      return resources.values unless resources.length.zero? || !request
      all!(params: params)
    end

    def all!(params)
      pages(params: params).to_a.flatten(1)
    end

    def each_page(per_page: PER_PAGE, params: {})
      Enumerator.new do |yielder|
        loop.with_index do |_, n|
          resources = page(n, per_page: per_page, params: params)
          yielder << resources
          break if resources.length < per_page
        end
      end
    end

    def each(per_page: PER_PAGE, params: {}, request: true)
      return resources.each_value unless resources.length.zero? || !request
      return each!(per_page: per_page, params: params)
    end

    def each!(per_page: PER_PAGE, params: {})
      Enumerator.new do |yielder|
        each_page(per_page: per_page, params: params) do |page|
          dummy_page.each do |resource|
            yielder << resource
          end
        end
      end
    end

    def find(id, request: true)
      return resources[id] if resources[id]
      return find!(id) if request
      raise Lightspeed::Error::NotFound, "Could not find a #{resource_name} with id=#{id}"
    end

    def find!(id)
      id_field =
      params = { resource_class.id_field => id }
      found = first!(params: params)
      return found if found
      raise Lightspeed::Error::NotFound, "Could not find a #{resource_name} with id=#{id}"
    end

    def create(attributes = {})
      instantiate(post(body: attributes.to_json)).first
    end

    def update(id, attributes = {})
      instantiate(put(id, body: attributes.to_json)).first
    end

    def destroy(id)
      instantiate(delete(id)).first
    end

    def self.collection_name
      name.demodulize
    end

    def self.resource_name
      collection_name.singularize
    end

    def self.resource_class
      "Lightspeed::#{resource_name}".constantize
    end

    def base_path
      "#{context.base_path}/#{resource_name}"
    end

    def inspect
      "#<#{self.class.name} API#{base_path}>"
    end

    private

    def page(n, per_page: PER_PAGE, params: {})
      params.merge!(offset: per_page * n) unless n.zero? # offset of `0` is a BadRequest.
      params.merge!(limit: per_page)
      load instantiate(get(params: params))
    end

    def dummy_page(n, options = {})
      resources = ((n * PER_PAGE)..((n + 1) * PER_PAGE - 1)).to_a
      resources = resources.take(10) if n >= 10 # infer last page
    end

    def instantiate(response)
      return [] unless response.is_a?(Hash)
      Array.wrap(response[resource_name]).map do |resource|
        resource = resource_class.new(collection: self, attributes: resource)
        self.resources[resource.id] = resource
      end
    end

    def resource_class
      self.class.resource_class
    end

    def resource_name
      self.class.resource_name
    end

    def get(params: {})
      params.merge!(load_relations: "all")
      client.get(
        path: collection_path,
        params: params
      )
    end

    def post(body:)
      client.post(
        path: collection_path,
        body: body
      )
    end

    def put(id, body:)
      client.put(
        path: resource_path(id),
        body: body,
      )
    end

    def delete(id)
      client.delete(
        path: resource_path(id)
      )
    end

    def collection_path
      "#{base_path}.json"
    end

    def resource_path(id)
      "#{base_path}/#{id}.json"
    end
  end
end
