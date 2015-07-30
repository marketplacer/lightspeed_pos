require 'spec_helper'

describe Lightspeed::Client do

  it "can set an API key" do
    key = 'test'
    client = Lightspeed::Client.new(api_key: key)
    expect(client.api_key).to eq(key)
  end

  it "can set an OAuth token" do
    key = 'test'
    client = Lightspeed::Client.new(oauth_token: key)
    expect(client.oauth_token).to eq(key)
  end

  it "can fetch accounts using an API key" do
    VCR.use_cassette("accounts") do
      client = Lightspeed::Client.new(api_key: 'test')
      accounts = client.accounts
      expect(accounts).to be_an(Array)
      expect(accounts.length).to eq(1)
      expect(accounts.first.id).to eq("113665")
    end
  end

  it "can fetch accounts using an OAuth token" do
    VCR.use_cassette("accounts_oauth") do
      client = Lightspeed::Client.new(oauth_token: 'test')
      accounts = client.accounts
      expect(accounts).to be_an(Array)
      expect(accounts.length).to eq(1)
      expect(accounts.first.id).to eq("113665")
    end
  end

  context "errors" do
    it "401" do
      client = Lightspeed::Client.new(api_key: 'totally-bogus')

      VCR.use_cassette("accounts_401") do
        expect { client.accounts }.to raise_error(Lightspeed::Errors::Unauthorized, "Invalid username/password or API key.")
      end
    end
  end
end
