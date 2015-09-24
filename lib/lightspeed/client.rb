require 'active_support/core_ext/array/wrap'

require_relative 'accounts'
require_relative 'request'

module Lightspeed
  class Client
    attr_accessor :api_key, :- OAuth test_token

    def initialize(api_key: nil, - OAuth test_token: nil)
      @api_key = api_key
      @- OAuth test_token = - OAuth test_token
    end

    # Returns a list of accounts that you have access to.
    def accounts
      @accounts = Lightspeed::Accounts.new(context: self)
    end

    def get(**args)
      request(args.merge(method: :get)).perform
    end

    def post(**args)
      request(args.merge(method: :post)).perform
    end

    def put(**args)
      request(args.merge(method: :put)).perform
    end

    def delete(**args)
      request(args.merge(method: :delete)).perform
    end

    private

    def request(**args)
      Lightspeed::Request.new(self, **args)
    end
  end
end
