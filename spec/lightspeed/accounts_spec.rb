# frozen_string_literal: true

require 'spec_helper'

describe Lightspeed::Accounts do
  describe "#page" do
    it "relays keyword arguments" do
      VCR.use_cassette("accounts_oauth", match_requests_on: [:anonymised_path, :method, :body, :headers]) do
        key = 'test'
        token_holder = ExampleTokenHolder.new(token: key)
        client = Lightspeed::Client.new(oauth_token_holder: token_holder)
        expect { client.accounts.all }.not_to raise_error ArgumentError
      end
    end
  end
end
