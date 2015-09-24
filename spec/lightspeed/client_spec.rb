require 'spec_helper'

describe Lightspeed::Client do
  it "can set an API key" do
    key = 'test'
    client = Lightspeed::Client.new(api_key: key)
    expect(client.api_key).to eq(key)
  end

  it "can set an oauth token" do
    key = 'test'
    client = Lightspeed::Client.new(oauth_token: key)
    expect(client.oauth_token).to eq(key)
  end

  it "sets the API key up for a request" do
    key = 'test'
    client = Lightspeed::Client.new(api_key: key)
    request = client.send(:request, method: :get, path: '/')
    expect(request.raw_request.options[:userpwd]).to eq("test:apikey")
  end

  it "sets the oauth token up for a request" do
    key = 'test'
    client = Lightspeed::Client.new(oauth_token: key)
    request = client.send(:request, method: :get, path: '/')
    expect(request.raw_request.options[:headers]["Authorization"]).to eq("oauth")
  end

  it "can fetch accounts using an API key" do
    VCR.use_cassette("accounts") do
      client = Lightspeed::Client.new(api_key: 'test')
      accounts = client.accounts
      expect(accounts).to be_a(Lightspeed::Accounts)
      expect(accounts.length).to eq(1)
      expect(accounts.first.id).to be(Lightspeed::TEST_ACCOUNT_ID)
    end
  end

  it "can fetch accounts using an oauth token" do
    VCR.use_cassette("accounts_oauth") do
      oauth_token = ENV.fetch('LIGHTSPEED_oauth_TOKEN', 'test')
      client = Lightspeed::Client.new(oauth_token: oauth_token)
      accounts = client.accounts
      expect(accounts).to be_a(Lightspeed::Accounts)
      expect(accounts.length).to eq(1)
      expect(accounts.first.id).to eq(Lightspeed::TEST_ACCOUNT_ID)
    end
  end

  context "errors" do
    it "401" do
      client = Lightspeed::Client.new(api_key: 'totally-bogus')

      VCR.use_cassette("accounts_401") do
        expect { client.accounts.all }.to raise_error(Lightspeed::Error::Unauthorized, "Invalid username/password or API key.")
      end
    end
  end
end
