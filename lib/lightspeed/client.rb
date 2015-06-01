module Lightspeed
  class Client
    include HTTParty

    base_uri "https://api.merchantos.com/API/"

    # Returns a list of accounts that you have access to.
    def accounts
      response = self.class.get("/Account.json")
      accounts = Lightspeed.instantiate(response["Account"], Lightspeed::Account)
    end
  end
end
