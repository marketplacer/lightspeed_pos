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

    def unload
      @resources = {}
    end

    def client
      return context if context.is_a?(Lightspeed::Client)
      account.client
    end

    def first(params: {})
      params = params.merge(limit: 1)
      instantiate(get(params: params)).first
    end

    def size(params: {})
      params = params.merge(limit: 1)
      get(params: {limit: 1})["@attributes"]["count"].to_i
    end
    alias_method :length, :size
    alias_method :count, :size

    def each_loaded
      @resources ||= {}
      @resources.each_value
    end

    def all_loaded
      each_loaded.to_a
    end

    def all(params: {})
      each_page(params: params).to_a.flatten(1)
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

    def each(per_page: PER_PAGE, params: {})
      Enumerator.new do |yielder|
        each_page(per_page: per_page, params: params).each do |page|
          page.each do |resource|
            yielder << resource
          end
        end
      end
    end

    def find(id)
      first(params: { resource_class.id_field => id }) || handle_not_found(id)
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
      "#{account.base_path}/#{resource_name}"
    end

    def inspect
      "#<#{self.class.name} API#{base_path}>"
    end

    def to_h
      all_loaded.map do |resource|
        {resource_name => resource.to_h}
      end
    end

    def to_json
      to_h.to_json
    end

    private

    def handle_not_found(id)
      raise Lightspeed::Error::NotFound, "Could not find a #{resource_name} with #{resource_class.id_field}=#{id}"
    end

    def page(n, per_page: PER_PAGE, params: {})
      params = params.merge(offset: per_page * n) unless n.zero? # offset of `0` is a BadRequest.
      params = params.merge(limit: per_page)
      instantiate(get(params: params))
    end

    def instantiate(response)
      return [] unless response.is_a?(Hash)
      @resources ||= {}
      Array.wrap(response[resource_name]).map do |resource|
        resource = resource_class.new(context: self, attributes: resource)
        @resources[resource.id] = resource
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
