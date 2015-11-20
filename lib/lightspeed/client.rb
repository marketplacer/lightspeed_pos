require 'active_support/core_ext/array/wrap'

require_relative 'accounts'
require_relative 'request'

module Lightspeed
  class Client
    attr_accessor :api_key, :oauth_token, :bucket_level, :bucket_max, :units_per_second

    def initialize(api_key: nil, oauth_token: nil)
      @api_key = api_key
      @oauth_token = oauth_token
      @units_per_second = 0.5
      @bucket_max = Float::INFINITY
      @bucket_level = 0
    end

    # Returns a list of accounts that you have access to.
    def accounts
      @accounts ||= Lightspeed::Accounts.new(context: self)
    end

    def load_json(json)
      data = JSON.parse(json)
      Array.wrap(data).map do |resource|
        resource = resource_class.new(context: self, attributes: resource)
        @resources[resource.id] = resource
      end
    end

    def get(**args)
      perform_request(:get, 1, args)
    end

    def post(**args)
      perform_request(:post, 10, args)
    end

    def put(**args)
      perform_request(:put, 10, args)
    end

    def delete(**args)
      perform_request(:delete, 10, args)
    end

    private

    def perform_request(method, units, **args)
      sleep(units / @units_per_second) if @bucket_level + units > @bucket_max
      req = request(args.merge(method: method))
      response = req.perform
      extract_rate_limits req
      response
    end

    def request(**args)
      Lightspeed::Request.new(self, **args)
    end

    def extract_rate_limits request
      @bucket_max, @bucket_level = request.bucket_max, request.bucket_level
      @units_per_second = @bucket_max/60.0
    end
  end
end
