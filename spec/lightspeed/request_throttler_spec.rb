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
end

describe Lightspeed::RequestThrottler do
  let(:client) { Lightspeed::Client.new(oauth_token_holder: ExampleTokenHolder.new(token: ENV.fetch('LIGHTSPEED_OAUTH_TOKEN', 'test'))) }

  it "can extract limits from API responses" do
    VCR.use_cassette("request_throttler/bucket_limits") do
      client.accounts.first
      expect(client.throttler.bucket_max).to eq 90.0
      expect(client.throttler.bucket_level).to eq 9.2179536819447
    end
  end

  pending "can slow down to avoid hitting the limit"
end
