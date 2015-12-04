require 'spec_helper'

describe Lightspeed::RequestThrottler do

  let(:client) { Lightspeed::Client.new(oauth_token: ENV.fetch('LIGHTSPEED_OAUTH_TOKEN', 'test')) }

  it "can extract limits from API responses" do
    VCR.use_cassette("request_throttler/bucket_limits") do
      client.accounts.first
      expect(client.throttler.bucket_max).to eq 60.0
      expect(client.throttler.bucket_level).to eq 1
    end
  end

  pending "can slow down to avoid hitting the limit"

end

