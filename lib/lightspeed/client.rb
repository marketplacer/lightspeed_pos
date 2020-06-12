# frozen_string_literal: true

require 'active_support/core_ext/array/wrap'

require_relative 'accounts'
require_relative 'request'
require_relative 'request_throttler'

module Lightspeed
  class Client
    attr_accessor :throttler

    def initialize(oauth_token_holder: nil, oauth_token: nil)
      @oauth_token_holder = oauth_token_holder
      @throttler = Lightspeed::RequestThrottler.new

      raise "Passing an oauth token is no longer supported. Pass a token holder instead." if oauth_token
    end

    # Returns a list of accounts that you have access to.
    def accounts
      @accounts ||= Lightspeed::Accounts.new(context: self)
    end

    def get(**args)
      perform_request(**args, method: :get)
    end

    def post(**args)
      perform_request(**args, method: :post)
    end

    def put(**args)
      perform_request(**args, method: :put)
    end

    def delete(**args)
      perform_request(**args, method: :delete)
    end

    def oauth_token
      @oauth_token_holder.oauth_token
    end

    def refresh_oauth_token
      @oauth_token_holder.refresh_oauth_token
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
