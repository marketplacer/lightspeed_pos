# frozen_string_literal: true

module ClientAndAccount
  class ExampleTokenHolder
    def initialize(token: nil, refresh_token: nil)
      @token = token
      @refresh_token = refresh_token
    end

    def oauth_token
      @token
    end
  end

  def setup_client_and_account
    let(:client) do
      token = Lightspeed::TEST_OAUTH_TOKEN || nil
      token_holder = ExampleTokenHolder.new(token: token)
      Lightspeed::Client.new(oauth_token_holder: token_holder)
    end

    let(:accounts) do
      Lightspeed::Accounts.new(context: client)
    end

    let(:account) do
      Lightspeed::Account.new(client: client, context: accounts, attributes: { "accountID" => Lightspeed::TEST_ACCOUNT_ID })
    end
  end
end

RSpec.configure do |c|
  c.extend ClientAndAccount
end
