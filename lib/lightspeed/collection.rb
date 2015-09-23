require 'active_support/core_ext/string'
require 'active_support/core_ext/array/wrap'

require_relative 'base'

module Lightspeed
  class Collection < Lightspeed::Base

    LIMIT = 100 # the max page of records returned in a request

    def first(params: {})
      params.merge!(limit: 1)
      response = get(params: params)
      craft_instance(response)
    end

    # this is messy for pagination purposes.
    def all(of: LIMIT, params: {}, limit: Float::INFINITY)
      all_records = []
      params.merge!(limit: of)
      loop.with_index do |_, i|
        break if all_records.length < LIMIT * i
        params.merge!(offset: of * i) unless i.zero?
        response = get(params: params)
        if response[resource_name]
          group_records = instantiate(records: response[resource_name])
        end
        yield(group_records) if block_given?
        all_records += group_records
        break if all_records.length >= limit
      end
      return all_records
    end
    alias_method :in_groups, :all

    def find(id)
      id_key = resource_class.id_field
      params = { id_key => id }
      response = get(params: params)
      if response[resource_name]
        craft_instance(response)
      else
        raise Lightspeed::Error::NotFound, "Could not find a #{resource_name} with #{id_key}=#{id}"
      end
    end

    def create(attributes = {})
      craft_instance(post(body: attributes.to_json))
    end

    def update(id, attributes = {})
      craft_instance(put(id, body: attributes.to_json))
    end

    def destroy(id)
      craft_instance(delete(id))
    end

    def self.collection_name
      name.demodulize
    end

    def self.resource_name
      collection_name.singularize
    end

    def self.resource_class
      Lightspeed.const_get(resource_name)
    end

    def instantiate(**args)
      account.instantiate({kind: resource_class, owner: self}.merge(args))
    end

    private

    def craft_instance(response)
      instantiate(records: response[resource_name]).first
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

    def base_path
      "/Account/#{account.id}/#{self.class.resource_name}"
    end

    def collection_path
      base_path + ".json"
    end

    def resource_path(id)
      base_path + "/#{id}.json"
    end

  end
end
