require 'bigdecimal'
require 'active_support/core_ext/string'
require 'active_support/core_ext/hash/slice'

require_relative 'collection'

module Lightspeed
  class ID < Integer; end
  class Link; end
  class Resource
    attr_accessor :id, :attributes, :client, :context, :account

    def initialize(client: nil, context: nil, attributes: {})
      self.client = client
      self.context = context
      self.attributes = attributes
    end

    def attributes=(attributes)
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
      attr_writer(*fields.keys)
      fields.each do |name, klass|
        @fields << define_method(name) do
          get_transformed_value(name, klass)
        end
      end
      @fields
    end

    def get_transformed_value(name, kind)
      value = instance_variable_get("@#{name}")
      if value.is_a?(String)
        case kind
        when :string then value
        when :integer then value.to_i
        when :id then value.to_i
        when :datetime then DateTime.parse(value)
        when :boolean then value == 'true'
        when :decimal then BigDecimal(value)
        when :hash then Hash.new(value)
        else
          raise ArgumentError, "Could not transform value #{value} to a #{kind}"
        end
      else
        value
      end
    end

    def client
      @client || context.try(:client)
    end

    def load
      self.attributes = get[resource_name] if (attributes.keys - [self.class.id_field]).empty?
    end

    def reload
      self.attributes = get[resource_name]
    end

    def update(attributes = {})
      self.attributes = put(body: Yajl::Encoder.encode(attributes))[resource_name]
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

    def id_params
      { self.class.id_field => id }
    end

    def self.relationships(*args)
      @relationships ||= []
      paired_args = args.flat_map { |r| r.is_a?(Hash) ? r.to_a : [[r, r]] }
      paired_args.each do |(relation_name, class_name)|
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
      Yajl::Encoder.encode(as_json)
    end

    def as_json
      fields_to_h.merge(relationships_to_h).reject { |_, v| v.nil? || v == {} }
    end
    alias_method :to_h, :as_json

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

    def read_attribute_for_serialization(method_name)
      method_name = method_name.to_sym

      if self.class.fields.include?(method_name) || self.class.relationships.include?(method_name)
        send(method_name)
      end
    end

    private

    def fields_to_h
      self.class.fields.map { |f| [f, send(f)] }.to_h
    end

    def relationships_to_h
      self.class.relationships.map { |r| [r.to_s.camelize, send(r).to_h] }.to_h
    end

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
      collection = klass.new(context: self, attributes: attributes[relation_name.to_s])
      instance_variable_set("@#{method_name}", collection)
    end

    def get_resource_relation(method_name, relation_name, klass)
      id_field = "#{relation_name.to_s.camelize(:lower)}ID" # parentID != #categoryID, so we can't use klass.id_field
      resource = if send(id_field).to_i.nonzero?
        rel_attributes = attributes[klass.resource_name] || { klass.id_field => send(id_field) }
        klass.new(context: self, attributes: rel_attributes).tap(&:load)
      end
      instance_variable_set("@#{method_name}", resource)
    end

    def context_params
      if context.respond_to?(:id_field) &&
         respond_to?(context.id_field.to_sym)
        { context.id_field => context.id }
      else
        {}
      end
    end

    def get(params: {})
      params = { load_relations: 'all' }.merge(context_params).merge(params)
      client.get(
        path: resource_path,
        params: params
      )
    end

    def put(body:)
      client.put(
        path: resource_path,
        body: body
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
