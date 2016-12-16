module ClientAndAccount
  def setup_client_and_account
    let(:client) do
      if !Lightspeed::TEST_OAUTH_TOKEN.blank?
        Lightspeed::Client.new(oauth_token: Lightspeed::TEST_OAUTH_TOKEN)
      else
        Lightspeed::Client.new
      end
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
