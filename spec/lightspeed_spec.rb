require 'spec_helper'

describe Lightspeed do
  it "can set an API key" do
    Lightspeed.configure do |c|
      c.api_key = 'abc1234'
    end

    expect(Lightspeed.default_options[:basic_auth]).to eq({
      username: "abc1234", password: "apikey"
    })
  end

  it "can set an OAuth token" do
    Lightspeed.configure do |c|
      c.oauth_token = 'abc1234'
    end

    expect(Lightspeed.default_options[:headers]).to eq({
      "Authorization" => "OAuth abc1234"
    })
  end
end
