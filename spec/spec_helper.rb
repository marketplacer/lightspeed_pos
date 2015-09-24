$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
Dotenv.load
require 'lightspeed_pos'
require 'webmock/rspec'
require 'vcr'
Dir[File.expand_path('support/**/*.rb', File.dirname(__FILE__))].each do |f|
  require f
end

Lightspeed::TEST_OAUTH_TOKEN = ENV.fetch('LIGHTSPEED_OAUTH_TOKEN', 'test')
Lightspeed::TEST_ACCOUNT_ID = ENV.fetch('LIGHTSPEED_ACCOUNT_ID', '117102').to_i

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes }
end
