require 'active_support/core_ext/string'
require 'active_support/core_ext/hash/slice'

require_relative 'collection'

module Lightspeed
  class ID; end
  class Link; end
  class Resource
    attr_accessor :id, :attributes, :client, :context, :account

    def initialize(client: nil, account: nil, context: nil, attributes: {})
      self.client = client
      self.context = context
      self.attributes = attributes
    end

    def attributes= attributes
      @attributes = attributes
      attributes.each do |key, value|
        send(:"#{key}=", value) if self.respond_to?(:"#{key}=")
      end
      self.id = send(self.class.id_field)
      attributes
    end

    def account
      @account || context.try(:account)
    end

    def self.fields(fields = {})
      @fields ||= []
      attr_writer *fields.keys
      fields.each do |name, klass|
        @fields << define_method(name) do
          get_transformed_value(name, klass)
        end
      end
      @fields
    end

    def get_transformed_value(name, klass)
      value = instance_variable_get("@#{name}")
      if value.is_a?(String)
        case
        when klass <= String then value
        when klass <= Integer then value.to_i
        when klass <= Lightspeed::ID then value == "0" ? nil : value.to_i
        when klass <= DateTime then DateTime.parse(value)
        when klass <= URI then URI.parse(value)
        when klass <= TrueClass, klass <= FalseClass then value == "true"
        else klass.new(value)
        end
      else
        value
      end
    end

    def client
      @client || context.try(:client)
    end

    def load
      self.attributes = get[resource_name] if (self.attributes.keys - [self.class.id_field]).empty?
    end

    def reload
      self.attributes = get[resource_name]
    end

    def update(attributes = {})
      self.attributes = put(body: attributes.to_json)[resource_name]
    end

    def destroy
      self.attributes = delete[resource_name]
      self
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

    def self.relationships *args
      @relationships ||= []
      args.map do |arg|
        arg.is_a?(Hash) ? arg.to_a : [[arg, arg]]
      end.flatten(1).each do |(relation_name, class_name)|
        method_name = relation_name.to_s.underscore.to_sym
        @relationships << define_method(method_name) do
          instance_variable_get("@#{method_name}") || get_relation(method_name, relation_name, class_name)
        end
      end
      @relationships
    end

    def inspect
      "#<#{self.class.name} API#{base_path}>"
    end

    def to_json
      to_h.to_json
    end

    def to_h
      self.class.fields.map { |f| [f, send(f)] }.to_h
    end

    def base_path
      if context.is_a?(Lightspeed::Collection)
        "#{context.base_path}/#{id}"
      else
        "#{account.base_path}/#{resource_name}/#{id}"
      end
    end

    def singular_path_parent
      context
    end

    def resource_name
      self.class.resource_name
    end

    private

    def collection_class
      "Lightspeed::#{self.class.collection_name}".constantize
    end

    def get_relation(method_name, relation_name, class_name)
      klass = "Lightspeed::#{class_name}".constantize
      case
      when klass <= Lightspeed::Collection then get_collection_relation(method_name, relation_name, klass)
      when klass <= Lightspeed::Resource then get_resource_relation(method_name, relation_name, klass)
      end
    end

    def get_collection_relation(method_name, relation_name, klass)
      resources = klass.new(context: self, attributes: attributes[relation_name])
      instance_variable_set("@#{method_name}", resources)
    end

    def get_resource_relation(method_name, relation_name, klass)
      id_field = "#{relation_name.to_s.camelize(:lower)}ID" #parentID != #categoryID, so we can't use klass.id_field
      resource = if send(id_field)
        rel_attributes = attributes[klass.resource_name] || { klass.id_field => send(id_field) }
        klass.new(context: self, account: account, attributes: rel_attributes).tap(&:load)
      end
      instance_variable_set("@#{method_name}", resource)
    end

    def get(params: {})
      params.merge!(load_relations: "all") # may be able to be pickier with this.
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
