require 'spec_helper'

describe Lightspeed::Client do
  before do
    Lightspeed.configure do |c|
      c.api_key = "test"
    end
  end

  it "can fetch accounts" do
    VCR.use_cassette("accounts") do
      client = Lightspeed::Client.new
      expect(client.accounts).to be_an(Array)
      expect(client.accounts.length).to eq(1)
      expect(client.accounts.first.id).to eq("113665")
    end
  end
end
