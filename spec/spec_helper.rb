$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
Dotenv.load
require 'lightspeed_pos'
require 'webmock/rspec'
require 'vcr'
Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each do |f|
  require f
end

Lightspeed::TEST_OAUTH_TOKEN = ENV.fetch('LIGHTSPEED_OAUTH_TOKEN', '')
Lightspeed::TEST_API_KEY = ENV.fetch('LIGHTSPEED_API_KEY', '')
Lightspeed::TEST_ACCOUNT_ID = ENV.fetch('LIGHTSPEED_ACCOUNT_ID', '117102').to_i

VCR.configure do |config|
  config.register_request_matcher :api_endpoint do |*reqs|
    call_1, call_2 = reqs.map do |req|
      # if the path includes an account number, only use path fragment after it
      # if the path does not include an account number, just use URI
      URI(req.uri).path.scan(/^\/.*\/\d+\/(.*)$/).flatten.first || req.uri
    end
    call_1 == call_2
  end

  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:api_endpoint, :method, :body]
  }
end
