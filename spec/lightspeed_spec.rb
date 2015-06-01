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
end
