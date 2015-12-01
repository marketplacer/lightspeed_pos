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
  config.register_request_matcher :anonymised_request_path do |*reqs|
    reqs.map { |req| URI(req.uri).path.sub(%r{(/Account/\d*/)}, '/Account/-/') }.uniq.size == 1
  end

  unless Lightspeed::TEST_OAUTH_TOKEN.blank?
    config.filter_sensitive_data('OAuth Token') { Lightspeed::TEST_OAUTH_TOKEN }
  end
  unless Lightspeed::TEST_API_KEY.blank?
    config.filter_sensitive_data('ApiKey') { Lightspeed::TEST_API_KEY }
  end

  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:anonymised_request_path, :method, :body]
  }
end
