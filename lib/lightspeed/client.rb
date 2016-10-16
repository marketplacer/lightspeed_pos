require 'active_support/core_ext/array/wrap'

require_relative 'accounts'
require_relative 'request'
require_relative 'request_throttler'

module Lightspeed
  class Client
    attr_accessor :api_key, :oauth_token, :throttler

    def initialize(oauth_token: nil, api_key: nil)
      @api_key = api_key
      @oauth_token = oauth_token
      @throttler = Lightspeed::RequestThrottler.new
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
      perform_request(args.merge(method: :get))
    end

    def post(**args)
      perform_request(args.merge(method: :post))
    end

    def put(**args)
      perform_request(args.merge(method: :put))
    end

    def delete(**args)
      perform_request(args.merge(method: :delete))
    end

    private

    def perform_request(**args)
      @throttler.perform_request request(**args)
    end

    def request **args
      Lightspeed::Request.new(self, **args)
    end

  end
end
