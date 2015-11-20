require 'active_support/core_ext/array/wrap'

require_relative 'accounts'
require_relative 'request'

module Lightspeed
  class Client
    attr_accessor :api_key, :oauth_token, :bucket_level, :bucket_max

    def initialize(api_key: nil, oauth_token: nil)
      @api_key = api_key
      @oauth_token = oauth_token
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
      perform_request(:get, args)
    end

    def post(**args)
      perform_request(:post, args)
    end

    def put(**args)
      perform_request(:put, args)
    end

    def delete(**args)
      perform_request(:delete, args)
    end

    private

    def perform_request(method, **args)
      req = request(args.merge(method: method))
      response = req.perform
      self.bucket_max, self.bucket_level = req.bucket_max, req.bucket_level
      response
    end

    def request(**args)
      Lightspeed::Request.new(self, **args)
    end
  end
end
