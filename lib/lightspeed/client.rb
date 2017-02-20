require 'active_support/core_ext/array/wrap'

require_relative 'accounts'
require_relative 'request'
require_relative 'request_throttler'
require_relative 'authorization_token_holder'
require_relative 'refresh_token_holder'

module Lightspeed
  class Client
    attr_accessor :throttler

    def initialize(oauth_token: nil, refresh_token: nil, client_id: nil, client_secret: nil)
      if refresh_token.nil?
        @token_holder = Lightspeed::AuthorizationTokenHolder.new oauth_token: oauth_token
      else
        @token_holder = Lightspeed::RefreshTokenHolder.new(
          refresh_token: refresh_token,
          client_id: client_id,
          client_secret: client_secret
        )
      end
      @throttler = Lightspeed::RequestThrottler.new
    end

    # Returns a list of accounts that you have access to.
    def accounts
      @accounts ||= Lightspeed::Accounts.new(context: self)
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

    def actual_token
      @token_holder.token
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
