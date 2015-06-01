require 'spec_helper'

describe Lightspeed::Client, configure: true do

  it "can fetch accounts" do
    VCR.use_cassette("accounts") do
      client = Lightspeed::Client.new
      expect(client.accounts).to be_an(Array)
      expect(client.accounts.length).to eq(1)
      expect(client.accounts.first.id).to eq("113665")
    end
  end

  context "errors" do
    it "401" do
      Lightspeed.configure do |c|
        c.api_key = 'totally-bogus'
      end

      client = Lightspeed::Client.new
      VCR.use_cassette("accounts_401") do
        expect { client.accounts }.to raise_error(Lightspeed::Errors::Unauthorized, "Invalid username/password or API key.")
      end
    end
  end
end
