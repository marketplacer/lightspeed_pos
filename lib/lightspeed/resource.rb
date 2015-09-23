require 'active_support/core_ext/string'

require_relative 'collection'

module Lightspeed
  class Resource < Lightspeed::Base

    attr_accessor :id, :attributes

    def initialize(owner, data = {})
      super(owner)
      @attributes = data
      self.id = data.delete(self.class.id_field).try(:to_i)
      data.each do |key, value|
        self.send(:"#{key}=", value) if self.respond_to?(:"#{key}=")
      end
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

    def self.has_one *class_names
      class_names.each do |name|
        define_method(name.to_s.underscore.to_sym) do
          klass = Lightspeed.const_get(name)
          return if attributes[klass.id_field].to_i.zero?
          ivar = "@#{name.to_s.underscore}"
          return instance_variable_get(ivar) if instance_variable_get(ivar)
          instance_variable_set(ivar, get_associated(klass))
        end
      end
    end

    def self.has_many *class_names
      class_names.each do |name|
        define_method(name.to_s.underscore.to_sym) do
          klass = Lightspeed.const_get(name)
          return if attributes[klass.resources_name].nil?
          ivar = "@#{name.to_s.underscore}"
          return instance_variable_get(ivar) if instance_variable_get(ivar)
          instance_variable_set(ivar, get_associated(klass))
        end
      end
    end

    def get_associated klass
      if klass.superclass == Lightspeed::Collection
        account.instantiate(records: attributes[klass.collection_name][klass.resource_name], kind: klass.resource_class, owner: self)
      elsif klass.superclass == Lightspeed::Resource
        if attributes[klass.resource_name]
          account.instantiate(records: attributes[klass.resource_name], kind: klass, owner: self)
        else
          account.send(klass.collection_name.underscore.to_sym).find(attributes[klass.id_field])
        end
      end
    end

    def inspect
      "#<#{self.class.name} id=#{id}>"
    end

    def to_json
      attributes.to_json
    end
  end
end
