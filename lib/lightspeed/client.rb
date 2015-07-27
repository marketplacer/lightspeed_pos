require 'lightspeed/account'
require 'lightspeed/request'

module Lightspeed
  class Client
    attr_accessor :api_key, :oauth_token

    def initialize(api_key: nil, oauth_token: nil)
      @api_key = api_key
      @oauth_token = oauth_token
    end

    def request(**args)
      Lightspeed::Request.new(self, **args)
    end

    # Returns a list of accounts that you have access to.
    def accounts
      request = request(method: :get, path: "/Account.json")
      response = request.perform
      instantiate(response["Account"], Lightspeed::Account)
    end

    # Instantiates a bunch of records from Lightspeed into their proper classes.
    def instantiate(records, klass)
      records = splat(records)
      records.map do |record|
        klass.new(self, record)
      end
    end

    private

    # Converts a thing to an Array unless it is already.
    # Unfortunately necessary because Lightspeed's API may return an object, 
    # or an array of objects.
    #
    # The compact is becuase it may return nothing at all.
    # In the example of fetching categories resource where there are no categories,
    # response["Category"] will not be present.
    def splat(thing)
      (thing.is_a?(Array) ? thing : [thing]).compact
    end
  end
end
