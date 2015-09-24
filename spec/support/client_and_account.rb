module ClientAndAccount
  def setup_client_and_account
    let(:client) do
      Lightspeed::Client.new(oauth_token: ENV.fetch('LIGHTSPEED_OAUTH_TOKEN', 'test'))
    end

    let(:account) do
      Lightspeed::Account.new(client).tap do |account|
        account.id = ENV.fetch('LIGHTSPEED_ACCOUNT_ID', 117_102)
      end
    end
  end
end

RSpec.configure do |c|
  c.extend ClientAndAccount
end
