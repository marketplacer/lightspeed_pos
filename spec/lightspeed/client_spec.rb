# frozen_string_literal: true

require 'spec_helper'

class ExampleTokenHolder
  def initialize(token: nil, refresh_token: nil)
    @token = token
    @refresh_token = refresh_token
  end

  def oauth_token
    @token
  end

  def refresh_oauth_token
    @token = @token + "_refreshed"
  end
end

describe Lightspeed::Client do
  it "can set an oauth token holder and fetch an access token from it" do
    key = 'test'
    token_holder = ExampleTokenHolder.new(token: key)
    client = Lightspeed::Client.new(oauth_token_holder: token_holder)
    expect(client.oauth_token).to eq(key)
  end

  it "sets the oauth token up for a request" do
    key = 'test'
    token_holder = ExampleTokenHolder.new(token: key)
    client = Lightspeed::Client.new(oauth_token_holder: token_holder)
    request = client.send(:request, method: :get, path: '/')
    expect(request.raw_request["Authorization"]).to eq("Bearer test")
  end

  it "can fetch accounts using an oauth token" do
    VCR.use_cassette("accounts_oauth", match_requests_on: [:anonymised_path, :method, :body, :headers]) do
      oauth_token = ENV.fetch('LIGHTSPEED_OAUTH_TOKEN', 'test')
      token_holder = ExampleTokenHolder.new(token: oauth_token)
      client = Lightspeed::Client.new(oauth_token_holder: token_holder)
      accounts = client.accounts
      expect(accounts).to be_a(Lightspeed::Accounts)
      expect(accounts.length).to eq(1)
      expect(accounts.first.id).to eq(120_645)
    end
  end

  it "will refresh an oauth token when it has expired" do
    VCR.use_cassette("accounts_oauth_with_refresh", match_requests_on: [:anonymised_path, :method, :body, :headers]) do
      token_holder = ExampleTokenHolder.new(token: 'test', refresh_token: 'unused')
      client = Lightspeed::Client.new(oauth_token_holder: token_holder)
      expect(client.oauth_token).to eq 'test'
      accounts = client.accounts
      expect(accounts).to be_a(Lightspeed::Accounts)
      expect(accounts.length).to eq(1)
      expect(accounts.first.id).to eq(120_645)
      expect(client.oauth_token).to eq 'test_refreshed'
    end
  end
end
