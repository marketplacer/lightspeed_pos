module ClientAndAccount
  def setup_client_and_account
    let(:client) do
      Lightspeed::Client.new(
        if !Lightspeed::TEST_OAUTH_TOKEN.blank?
          { oauth_token: Lightspeed::TEST_OAUTH_TOKEN }
        end
      )
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
