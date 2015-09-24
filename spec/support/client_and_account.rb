module ClientAndAccount
  def setup_client_and_account
    let(:client) do
      Lightspeed::Client.new(oauth_token: Lightspeed::TEST_OAUTH_TOKEN)
    end

    let(:accounts) do
      Lightspeed::Accounts.new(context: client)
    end

    let(:account) do
      Lightspeed::Account.new(client: client, collection: accounts, attributes: {"accountID" => Lightspeed::TEST_ACCOUNT_ID})
    end
  end
end

RSpec.configure do |c|
  c.extend ClientAndAccount
end
