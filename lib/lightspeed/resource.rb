require 'active_support/core_ext/string'
require 'active_support/core_ext/hash/slice'

require_relative 'collection'

module Lightspeed
  class Resource
    attr_accessor :id, :collection, :attributes, :client, :context

    def initialize(client: nil, collection: nil, context: nil, attributes: {})
      self.collection = collection
      self.client = client
      self.context = context
      self.attributes = attributes
    end

    def attributes= attributes
      @attributes = attributes
      self.id = attributes.dup.delete(self.class.id_field).try(:to_i)
      attributes.each do |key, value|
        send(:"#{key}=", value) if self.respond_to?(:"#{key}=")
      end
    end

    def account
      collection.try(:account) || context.try(:account)
    end

    def client
      @client || collection.try(:client) || context.try(:client)
    end

    def fetch
      attributes = get[resource_name]
    end

    def update(attributes = {})
      attributes = put(body: attributes.to_json)[resource_name]
    end

    def destroy
      attributes = delete[resource_name]
    end


    def self.resource_name
      name.demodulize
    end

    def self.collection_name
      resource_name.pluralize
    end

    def self.id_field
      "#{resource_name.camelize(:lower)}ID"
    end

    def self.relate *class_names
      class_names.each do |name|
        define_method(name.to_s.underscore.to_sym) do
          instance_variable_get("@#{name.to_s.underscore}") || get_relation(name)
        end
      end
    end

    def inspect
      "#<#{self.class.name} API#{base_path}>"
    end

    def to_json
      attributes.to_json
    end

    def base_path
      if collection
        "#{collection.base_path}/#{id}"
      elsif context
        "#{context.base_path}/#{resource_name}/#{id}"
      end
    end
    private

    def collection_class
      Lightspeed.const_get(self.class.collection_name)
    end

    def get_relation(name)
      klass = Lightspeed.const_get(name)
      if klass <= Lightspeed::Collection
        get_one_to_many_relation(klass, name)
      elsif klass <= Lightspeed::Resource
        get_one_to_one_relation(klass, name)
      end
    end

    def get_one_to_many_relation(klass, name)
      resources = klass.new(context: self, attributes: attributes[klass.collection_name])
      instance_variable_set("@#{name.to_s.underscore}", resources)
    end

    def get_one_to_one_relation(klass, name)
      resource = if attributes[klass.id_field].to_i.zero?
        nil
      elsif attributes[klass.resource_name]
        klass.new(context: self, attributes: attributes[klass.resource_name])
      else
        klass.new(context: self, attributes: attributes.slice(klass.id_field)).tap(&:fetch)
      end
      instance_variable_set("@#{name.to_s.underscore}", resource)
    end

    def get(params: {})
      params.merge!(load_relations: "all")
      client.get(
        path: resource_path,
        params: params
      )
    end

    def put(body:)
      client.put(
        path: resource_path,
        body: body,
      )
    end

    def delete
      client.delete(
        path: resource_path
      )
    end

    def resource_path
      "#{base_path}.json"
    end

  end
end
