require 'lightspeed/account'

module Lightspeed
  class Client

    # Returns a list of accounts that you have access to.
    def accounts
      response = Lightspeed.request(:get, "/Account.json")
      Lightspeed.instantiate(response["Account"], Lightspeed::Account)
    end
  end
end
