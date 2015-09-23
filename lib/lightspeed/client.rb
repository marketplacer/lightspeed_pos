require 'active_support/core_ext/array/wrap'

require_relative 'account'
require_relative 'request'

module Lightspeed
  class Client
    attr_accessor :api_key, :oauth_token

    def initialize(api_key: nil, oauth_token: nil)
      @api_key = api_key
      @oauth_token = oauth_token
    end

    # Returns a list of accounts that you have access to.
    def accounts
      request = request(method: :get, path: "/Account.json")
      response = request.perform
      instantiate(records: response["Account"], kind: Lightspeed::Account)
    end

    def account
      accounts.first
    end

    def client
      self
    end

    # Instantiates a bunch of records from Lightspeed into their proper classes.
    def instantiate(records:, kind:, owner: self)
      records = Array.wrap(records)
      records.map do |record|
        kind.new(owner, record)
      end
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
